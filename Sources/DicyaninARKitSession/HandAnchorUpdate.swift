/*
 * DicyaninARKitSession
 * Created by Hunter Harris on 04/03/2025
 * Copyright © 2025 Dicyanin Labs. All rights reserved.
 */

import RealityKit
import ARKit

/// Structure containing hand tracking data for both hands
public struct HandAnchorUpdate {
    /// Left hand anchor if available
    public var left: HandAnchor?
    /// Right hand anchor if available
    public var right: HandAnchor?
    
    /// Creates a new hand anchor update
    /// - Parameters:
    ///   - left: The left hand anchor
    ///   - right: The right hand anchor
    public init(left: HandAnchor? = nil, right: HandAnchor? = nil) {
        self.left = left
        self.right = right
    }
} 