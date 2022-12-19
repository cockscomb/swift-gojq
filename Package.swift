// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SwiftGoJq",
    platforms: [
        .macOS(.v13),
        .macCatalyst(.v14),
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "SwiftGoJq",
            targets: ["SwiftGoJq"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.3"),
    ],
    targets: [
        .binaryTarget(
            name: "GOJQBinding",
            path: "Frameworks/GOJQBinding.xcframework"),
        .target(
            name: "SwiftGoJq",
            dependencies: [
                "GOJQBinding",
            ]),
        .testTarget(
            name: "SwiftGoJqTests",
            dependencies: [
                "SwiftGoJq",
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ]),
    ]
)
