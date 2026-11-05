// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Binary release coordinates
//
// These two constants are rewritten by .github/workflows/release.yml whenever
// a new version of the underlying Rust framework is released. Do not edit by
// hand unless you know what you're doing — keep both in sync with the asset
// uploaded to the matching GitHub Release.
let libcelReleaseURL = "https://github.com/superwall/superscript-ios-next/releases/download/1.0.18/libcel.xcframework.zip"
let libcelChecksum = "d3aa4d26a24d41c33af0a8ee27115c90457308b39fbe995cc42d2a7eab7afd11"

let package = Package(
  name: "Superscript",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .watchOS(.v8),
    .tvOS(.v15)
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
  ],
  // The generated bindings in cel.swift are written for Swift 5.
  swiftLanguageModes: [.v5]
)
