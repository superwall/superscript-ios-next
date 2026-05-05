// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Binary release coordinates
//
// These two constants are rewritten by .github/workflows/release.yml whenever
// a new version of the underlying Rust framework is released. Do not edit by
// hand unless you know what you're doing — keep both in sync with the asset
// uploaded to the matching GitHub Release.
let libcelReleaseURL = "https://github.com/superwall/superscript-ios-next/releases/download/1.0.14/libcel.xcframework.zip"
let libcelChecksum = "191551707257580fa184ec2ccec625c3762530b368703d011822643f037353e4"

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
