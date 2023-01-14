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
        .package(url: "https://github.com/cockscomb/swift-package-checksum-rewriter", from: "0.1.0"),
    ],
    targets: [
        .binaryTarget(
            name: "GOJQBinding",
            url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.1/GOJQBinding.xcframework.zip",
            checksum: "c1743555992a00a3adaa6762ebbfc9f0354bdc518b7e83e47eb94cbd1c2a2155"),
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
