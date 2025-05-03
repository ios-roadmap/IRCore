// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IRCore",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "IRCore",
            targets: ["IRCore"]
        ),
    ],
    dependencies: [
        .package(name: "IRFoundation", path: "../IRFoundation"),
    ],
    targets: [
        .target(
            name: "IRCore",
            dependencies: [
                "IRFoundation"
            ],
            path: "IRCore"
        ),
        .testTarget(
            name: "IRCoreTests",
            dependencies: ["IRCore"],
            path: "IRCoreTests"
        )
    ]
)
