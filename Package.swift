// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OBS-Socket",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(
            name: "Debug",
            targets: ["OBS-Socket"]),
        .library(
            name: "OBS-Socket",
            targets: ["OBS-Socket"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "OBS-Socket"),
        .testTarget(
            name: "OBS-SocketTests",
            dependencies: ["OBS-Socket"]),
    ]
)
