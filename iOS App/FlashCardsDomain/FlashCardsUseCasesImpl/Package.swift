// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlashCardsUseCasesImpl",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FlashCardsUseCasesImpl",
            targets: ["FlashCardsUseCasesImpl"]),
    ],
    dependencies: [
        .package(name: "FlashCardsUseCases", path: "../../Domain/FlashCardsUseCases"),
        .package(name: "FlashCardsRepositories", path: "../../Data/FlashCardsRepositories"),
    ],
    targets: [
        .target(
            name: "FlashCardsUseCasesImpl",
            dependencies: ["FlashCardsUseCases",
                           "FlashCardsRepositories",
            ]),
        .testTarget(
            name: "FlashCardsUseCasesImplTests",
            dependencies: ["FlashCardsUseCasesImpl"]),
    ]
)
