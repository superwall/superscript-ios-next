// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Binary release coordinates
//
// These two constants are rewritten by .github/workflows/release.yml whenever
// a new version of the underlying Rust framework is released. Do not edit by
// hand unless you know what you're doing — keep both in sync with the asset
// uploaded to the matching GitHub Release.
let libcelReleaseURL = "https://github.com/superwall/superscript-ios-next/releases/download/1.0.16/libcel.xcframework.zip"
let libcelChecksum = "b71123a9681a0d82b059155d2b4d2249dcd7ea293301cf7b733017586f83d297"

let package = Package(
  name: "Superscript",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .watchOS(.v8)
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
