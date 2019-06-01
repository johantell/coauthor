// swift-tools-version:4.0

import PackageDescription

let packages = Package(
  name: "Coauthor",
  products: [
    .library(name: "CoauthorLib", targets: ["CoauthorLib"]),
    .executable(name: "coauthor", targets: ["Coauthor"]),
  ],
  dependencies: [
    .package(url: "https://github.com/Quick/Quick", from: "2.1.0"),
    .package(url: "https://github.com/Quick/Nimble", from: "8.0.1"),
    .package(url: "https://github.com/JohnSundell/ShellOut", from: "2.2.0"),
  ],
  targets: [
    .target(
      name: "CoauthorLib",
      dependencies: ["ShellOut"],
      path: "./Sources/CoauthorLib"
    ),
    .target(
      name: "Coauthor",
      dependencies: ["CoauthorLib"],
      path: "./Sources/Coauthor"
    ),
    .testTarget(
      name: "coauthorTests",
      dependencies: ["CoauthorLib", "Quick", "Nimble"],
      path: "./Tests"
    ),
  ]
)
