// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProviderManager",
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.5.0"),
        .package(url: "https://github.com/vapor/websocket-kit", from: "1.1.2")
    ],
    targets: [
        .target(
            name: "ProviderManager",
            dependencies: ["SPMUtility", "WebSocket"]),
        .testTarget(
            name: "ProviderManagerTests",
            dependencies: ["ProviderManager"]),
    ]
)
