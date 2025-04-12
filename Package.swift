// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Backpack-SwiftUI",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v11),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Backpack-SwiftUI",
            targets: ["Backpack-SwiftUI"]),
    ],
    targets: [
        .target(
            name: "Backpack-SwiftUI",
            path: "Backpack-SwiftUI/",
            resources: [.process("Backpack-Common/Icons/")])
    ],
    swiftLanguageVersions: [.v5]
)
