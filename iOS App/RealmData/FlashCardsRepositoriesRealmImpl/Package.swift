// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlashCardsRepositoriesRealmImpl",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FlashCardsRepositoriesRealmImpl",
            targets: ["FlashCardsRepositoriesRealmImpl"]),
    ],
    dependencies: [
        // Implementation using Realm
        .package(name: "Realm", url: "https://www.github.com/realm/realm-cocoa.git", from: "10.6.0"),
        // Protocols for the Data layer
        .package(name: "FlashCardsRepositories", path: "../../Data/FlashCardsRepositories")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FlashCardsRepositoriesRealmImpl",
            dependencies: [
                "FlashCardsRepositories",
                .product(name: "RealmSwift", package: "Realm")
            ]),
        .testTarget(
            name: "FlashCardsRepositoriesRealmImplTests",
            dependencies: [
                "FlashCardsRepositoriesRealmImpl",
                .product(name: "RealmSwift", package: "Realm")
            ]),
    ]
)
