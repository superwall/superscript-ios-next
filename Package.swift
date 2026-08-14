// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Binary release coordinates
//
// These two constants are rewritten by .github/workflows/release.yml whenever
// a new version of the underlying Rust framework is released. Do not edit by
// hand unless you know what you're doing — keep both in sync with the asset
// uploaded to the matching GitHub Release.
let libcelReleaseURL = "https://github.com/superwall/superscript-ios-next/releases/download/1.0.15/libcel.xcframework.zip"
let libcelChecksum = "71a4ac06d61c69a973bd3f5df0c771dd97a8e92e4135ee534e091a40f0c0de0a"

let package = Package(
  name: "Superscript",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_12),
    .watchOS("6.2")
  ],
  products: [
    .library(
      name: "Superscript",
      targets: ["Superscript"]
    )
  ],
  targets: [
    .target(
      name: "Superscript",
      dependencies: [
        .target(name: "libcel")
      ]
    ),
    .binaryTarget(
      name: "libcel",
      url: libcelReleaseURL,
      checksum: libcelChecksum
    ),
    .testTarget(
      name: "SuperscriptTests",
      dependencies: ["Superscript"]
    )
  ]
)
