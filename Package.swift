// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DicyaninARKitSession",
    platforms: [
        .iOS(.v17),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "DicyaninARKitSession",
            targets: ["DicyaninARKitSession"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DicyaninARKitSession",
            dependencies: []),
        .testTarget(
            name: "DicyaninARKitSessionTests",
            dependencies: ["DicyaninARKitSession"]),
    ]
) 