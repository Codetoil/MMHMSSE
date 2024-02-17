// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Game",
    platforms: [
        .macOS(.v14),
        .visionOS(.v1)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "GameCommon",
                 type: .dynamic,
                 targets: ["GameCommon"]),
        .executable(name: "GameVisionOS",
                    targets: ["GameVisionOS"])
    ],
    dependencies: [
        .package(url: "https://github.com/kevinw/GodotVision", revision: "59e4d8c1387190dd87b7e89ab2237e27c4fec923"),
        .package(url: "https://github.com/multijam/SwiftGodot", revision: "d80f53a47ed6f3a8f062ee2685823d013e178586")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies
        .executableTarget(
            name: "GameVisionOS",
            dependencies: ["GameCommon", "GodotVision"],
            exclude: ["Info.plist"],
            resources: [
                .process("Preview Content/Preview Assets.xcassets"),
                .process("Assets.xcassets")],
            swiftSettings: [.unsafeFlags(["-suppress-warnings"])]),
        .target(
            name: "GameCommon",
            dependencies: ["SwiftGodot"],
            swiftSettings: [.unsafeFlags(["-suppress-warnings"])]),
        .testTarget(
            name: "GameVisionOSTests",
            dependencies: ["GameVisionOS"]),
    ]
)
