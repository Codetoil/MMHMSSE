// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Game",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "game-visionOS",
            targets: ["game-visionOS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kevinw/GodotVision", revision: "22b17c5026b4226df0f3fd24d062de2ea1097a0d")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "game-common"),
        .target(
            name: "game-visionOS",
            dependencies: ["game-common"]),
        .testTarget(
            name: "game-visionOSTests",
            dependencies: ["game-visionOS"]),
    ]
)
