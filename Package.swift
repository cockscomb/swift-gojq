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
            url: "https://github.com/cockscomb/swift-gojq/releases/download/0.1.0/GOJQBinding.xcframework.zip",
            checksum: "1c45710de17fb7020dcfc75105344729725c5e3875e7058e98790e5f4e178162"),
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
