// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DiskStorage",
    platforms: [
      .macOS(.v14),
      .iOS(.v17),
      .tvOS(.v17)
  ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DiskStorage",
            targets: ["DiskStorage"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.2.0"),
        .package(url: "https://github.com/JohnSundell/Codextended", from: "0.3.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DiskStorage",
            dependencies: ["Files"]),
        .testTarget(
            name: "DiskStorageTests",
            dependencies: ["DiskStorage", "Files", "Codextended"]),
    ]
)
