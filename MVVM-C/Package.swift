// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MVVM-C",
    defaultLocalization: "en",
    platforms: [
            .iOS(.v8)
    ],
    dependencies: [
        .package(name: "danger-swift", url: "https://github.com/danger/swift.git", from: "4.0.0")
    ],
    targets: [
        // This is just an arbitrary Swift file in our app, that has
        // no dependencies outside of Foundation, the dependencies section
        // ensures that the library for Danger gets build also.
        .target(
            name: "MVVM-C",
            dependencies: [
                .product(name: "Danger", package: "danger-swift")
            ],
            path: "MVVM-C",
            exclude:["Info.plist"]
        ),
    ]
)
