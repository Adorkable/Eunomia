// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Eunomia",
    platforms: [
        .macOS(.v10_12), .iOS(.v10),
    ],
    products: [
        .library(name: "Eunomia", targets: ["Eunomia"]),
    ],
    targets: [
        .target(
            name: "Eunomia",
            path: "Source"
        ),
        // Ok: Swift Package Manager doesn't allow overlapping source???
//        .target(
//            name: "Eunomia-macOS",
//            dependencies: [
//            ],
//            path: "Source"
//        ),
    ]
)
