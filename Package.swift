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
            url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.3/GOJQBinding.xcframework.zip",
            checksum: "375656af225e53be2f80883afdd6117b3e2a6d9764924756032fcc7668d2baa9"),
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
