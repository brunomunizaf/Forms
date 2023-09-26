// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "Forms",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "Forms",
      targets: ["Forms"]),
  ],
  targets: [
    .target(
      name: "Forms"),
    .testTarget(
      name: "FormsTests",
      dependencies: ["Forms"]),
  ]
)
