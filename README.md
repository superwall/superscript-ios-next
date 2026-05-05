# Superscript (iOS)

A Common Expression Language (CEL) evaluator used by [SuperwallKit](https://github.com/superwall/Superwall-iOS), built in Rust and shipped as a binary `XCFramework`.

This is the slim successor to [`superscript-ios`](https://github.com/superwall/superscript-ios). Unlike the original repo — which committed the ~250 MB `libcel.xcframework` into git on every release and grew to ~1.2 GB of history — this repo keeps the git tree tiny and distributes the framework as a [GitHub Release asset](https://github.com/superwall/superscript-ios-next/releases). SPM's `binaryTarget(url:checksum:)` downloads it on demand.

## Swift Package Manager

```swift
.package(url: "https://github.com/superwall/superscript-ios-next.git", from: "1.0.0")
```

Then add `Superscript` as a target dependency.

## CocoaPods

```ruby
pod 'Superscript', '~> 1.0'
```

The pod's `prepare_command` downloads the xcframework from the matching GitHub Release at install time.

## How releases work

Releases are produced by `.github/workflows/release.yml` in response to a `repository_dispatch` event triggered by the upstream Rust repo, [`superwall/superscript`](https://github.com/superwall/superscript). On each release the workflow:

1. Builds `libcel.xcframework` from the Rust source.
2. Zips the framework and uploads it as a release asset on a new tag.
3. Computes the Swift Package Manager checksum and rewrites `Package.swift` and `Superscript.podspec` to reference the new release.
4. Commits the (small) text changes and pushes the tag.

No binaries ever land in git.
