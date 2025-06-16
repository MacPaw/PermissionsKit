// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PermissionsKit",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "PermissionsKit",
            targets: ["PermissionsKit"]
        )
    ],
    targets: [
        .target(
            name: "PermissionsKit",
            path: "PermissionsKit",
            sources: [
                "Public",
                "Private"
            ],
            linkerSettings: [
                .linkedFramework("Cocoa"),
                .linkedFramework("Contacts"),
                .linkedFramework("EventKit"),
                .linkedFramework("Photos")
            ]
        )
    ]
) 