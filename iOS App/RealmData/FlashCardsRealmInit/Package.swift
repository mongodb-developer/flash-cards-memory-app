// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlashCardsRealmInit",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FlashCardsRealmInit",
            targets: ["FlashCardsRealmInit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Realm", url: "https://www.github.com/realm/realm-cocoa.git", from: "10.6.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FlashCardsRealmInit",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm")
            ]),
        .testTarget(
            name: "FlashCardsRealmInitTests",
            dependencies: [
                "FlashCardsRealmInit",
                .product(name: "RealmSwift", package: "Realm")
            ]),
    ]
)
