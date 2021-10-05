// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlashCardsUI",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FlashCardsUI",
            targets: ["FlashCardsUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "FlashCardsUseCasesImpl", path: "../../FlashCardsDomain/FlashCardsUseCasesImpl"),
        .package(name: "FlashCardsRepositoriesRealmImpl", path: "../../RealmData/FlashCardsRepositoriesRealmImpl"),
        .package(name: "FlashCardsRealmInit", path: "../../RealmData/FlashCardsRealmInit"),
        .package(name: "FlashCardsModelsImpl", path: "../../FlashCardsDomain/FlashCardsModelsImpl")

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FlashCardsUI",
            dependencies: ["FlashCardsUseCasesImpl",
                           "FlashCardsRepositoriesRealmImpl",
                           "FlashCardsRealmInit",
                           "FlashCardsModelsImpl"
                          ]),
        .testTarget(
            name: "FlashCardsUITests",
            dependencies: ["FlashCardsUI"]),
    ]
)
