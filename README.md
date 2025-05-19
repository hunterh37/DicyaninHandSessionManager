# DicyaninARKitSession

A Swift package that provides a shared ARKit session manager for hand tracking in visionOS applications.

## Overview

DicyaninARKitSession manages a single ARKit session and distributes hand tracking updates to multiple subscribers. It ensures that only one ARKit session is running at a time, even when multiple packages need hand tracking data.

## Requirements

- visionOS 1.0+
- Swift 5.9+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/hunterh37/DicyaninARKitSession.git", from: "1.0.0")
]


## Usage

```swift
import DicyaninARKitSession

// Subscribe to hand tracking updates
let cancellable = ARKitSessionManager.shared.handTrackingUpdates
    .sink { update in
        // Handle hand tracking update
        if let leftHand = update.left {
            // Process left hand data
        }
        if let rightHand = update.right {
            // Process right hand data
        }
    }

// Start the session
try await ARKitSessionManager.shared.start()

// Stop the session when done
ARKitSessionManager.shared.stop()
```

## License

Copyright © 2025 Dicyanin Labs. All rights reserved. 
