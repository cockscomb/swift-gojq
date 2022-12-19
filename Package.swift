// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-gojq",
    platforms: [
        .macOS(.v13),
        .macCatalyst(.v14),
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "swift-gojq",
            targets: ["swift-gojq"]),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "GOJQBinding",
            path: "Frameworks/GOJQBinding.xcframework"),
        .target(
            name: "swift-gojq",
            dependencies: [
                "GOJQBinding",
            ]),
        .testTarget(
            name: "swift-gojqTests",
            dependencies: ["swift-gojq"]),
    ]
)
