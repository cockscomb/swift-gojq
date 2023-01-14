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
            url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.4/GOJQBinding.xcframework.zip",
            checksum: "f6b04f34d358677a5d00f31ab4c80aa2062d43b2bc480d8356f44abd05e5aea9"),
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
