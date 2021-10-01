// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlashCardsMappersImpl",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FlashCardsMappersImpl",
            targets: ["FlashCardsMappersImpl"]),
    ],
    dependencies: [
        .package(name: "FlashCardsModelsImpl", path: "../FlashCardsModelsImpl"),
        .package(name: "FlashCardsDataEntitiesImpl", path: "../../FlashCardsData/FlashCardsDataEntitiesImpl")
    ],
    targets: [
        .target(
            name: "FlashCardsMappersImpl",
            dependencies: [
                "FlashCardsDataEntitiesImpl",
                "FlashCardsModelsImpl"]),
        .testTarget(
            name: "FlashCardsMappersImplTests",
            dependencies: ["FlashCardsMappersImpl"]),
    ]
)
