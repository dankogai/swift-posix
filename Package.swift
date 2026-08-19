// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "swift-posix",
    products: [
        // one product, two modules:
        //   import POSIX         — everything under the POSIX namespace
        //   import POSIXGlobals  — everything at the top level, Perl-style
        .library(name: "POSIX", targets: ["POSIX", "POSIXGlobals"])
    ],
    targets: [
        .target(name: "POSIXGlobals"),
        .target(name: "POSIX", dependencies: ["POSIXGlobals"]),
        .testTarget(name: "POSIXTests", dependencies: ["POSIX", "POSIXGlobals"]),
    ]
)
