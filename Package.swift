// swift-tools-version:4.0

import PackageDescription

let packages = Package(
    name: "Coauthor",
    products: [
      .executable(name: "coauthor", targets: ["Coauthor"])
    ],
    dependencies: [
      .package(url: "https://github.com/Quick/Quick", from: "2.1.0"),
      .package(url: "https://github.com/Quick/Nimble", from: "8.0.1"),
    ],
    targets: [
        .target(
            name: "Coauthor",
            path: "./",
            sources: ["src"]),
        .testTarget(
            name: "coauthorTests",
            dependencies: ["Coauthor", "Quick", "Nimble"],
            path: "./Tests")
    ]
)

