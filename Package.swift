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
        .library(name: "Game",
                 type: .dynamic,
                 targets: ["Game"])
    ],
    dependencies: [
        .package(url: "https://github.com/multijam/SwiftGodot", revision: "d80f53a47ed6f3a8f062ee2685823d013e178586")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies
        .target(
            name: "Game",
            dependencies: ["SwiftGodot"],
            swiftSettings: [.unsafeFlags(["-suppress-warnings"])]),
        .testTarget(
            name: "GameTests",
            dependencies: ["Game"])
    ]
)
