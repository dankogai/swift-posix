// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "swift-posix",
    products: [
        .library(name: "POSIX", targets: ["POSIX"])
    ],
    targets: [
        .target(name: "POSIX"),
        .testTarget(name: "POSIXTests", dependencies: ["POSIX"]),
    ]
)
