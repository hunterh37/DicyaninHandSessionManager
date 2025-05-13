/*
 * DicyaninARKitSession
 * Created by Hunter Harris on 04/03/2025
 * Copyright © 2025 Dicyanin Labs. All rights reserved.
 */

import RealityKit
import ARKit
import Combine

/// Errors that can occur during ARKit session management
public enum ARKitSessionError: Error {
    /// The device does not support hand tracking
    case handTrackingNotSupported
}

/// A shared manager for ARKit sessions that distributes hand tracking updates to multiple packages
///
/// This class manages a single ARKit session and distributes hand tracking updates
/// to multiple subscribers. It ensures that only one ARKit session is running at a time,
/// even when multiple packages need hand tracking data.
///
/// Example usage:
/// ```swift
/// // Subscribe to hand tracking updates
/// let cancellable = ARKitSessionManager.shared.handTrackingUpdates
///     .sink { update in
///         // Handle hand tracking update
///     }
///
/// // Start the session
/// try await ARKitSessionManager.shared.start()
/// ```
public class ARKitSessionManager {
    /// Shared instance of the session manager
    public static let shared = ARKitSessionManager()
    
    private var session = ARKitSession()
    private var handTracking = HandTrackingProvider()
    private let handTrackingSubject = PassthroughSubject<HandAnchorUpdate, Never>()
    
    /// Publisher that emits hand tracking updates
    public var handTrackingUpdates: AnyPublisher<HandAnchorUpdate, Never> {
        handTrackingSubject.eraseToAnyPublisher()
    }
    
    private var isRunning = false
    private var subscribers = 0
    
    private init() {}
    
    /// Starts the ARKit session if it's not already running
    /// - Throws: `ARKitSessionError.handTrackingNotSupported` if the device doesn't support hand tracking
    public func start() async throws {
        guard HandTrackingProvider.isSupported else {
            throw ARKitSessionError.handTrackingNotSupported
        }
        
        subscribers += 1
        
        if !isRunning {
            handTracking = HandTrackingProvider()
            try await session.run([handTracking])
            isRunning = true
            await publishHandTrackingUpdates()
        }
    }
    
    /// Stops the ARKit session if there are no more subscribers
    public func stop() {
        subscribers -= 1
        
        if subscribers <= 0 {
            session.stop()
            isRunning = false
            subscribers = 0
        }
    }
    
    private func publishHandTrackingUpdates() async {
        for await update in handTracking.anchorUpdates {
            guard update.anchor.isTracked else { continue }
            
            let handUpdate = HandAnchorUpdate(
                left: update.anchor.chirality == .left ? update.anchor : nil,
                right: update.anchor.chirality == .right ? update.anchor : nil
            )
            
            handTrackingSubject.send(handUpdate)
        }
    }
} 