# `secp256k1` Library - Craig S. Wrong's Fork

## Why fork?

I forked the original Bitcoin Core's library to add:

 - A `Dockerfile` with build procedures for various configurations.
 - A shell script to target macOS and package as XCFramework.

This way the library can be used in Swift projects using Swift Package Manager (SPM) on both Mac and Linux platforms.

PRs welcome. If you need to contact me just DM me at `twitter.com/notcraigwright`.

## Usage

Add a binary target to your `Package.swift`. Use the `XCFramework` ZIP file attached to an specific [release](https://github.com/craigwrong/secp256k1/releases). Also attached is the corresponding checksum needed for the binary target.

    // …
    targets: [
        .binaryTarget(name: "secp256k1",
            url: "https://github.com/craigwrong/secp256k1/releases/download/22.0.1-craigwrong.1/secp256k1.xcframework.zip", checksum: "fff5415b72449331212cb75c71a47445cbe54fed061dc82153dcadbffae10f69"),
        .target(
            name: "ECHelper",
            dependencies: ["secp256k1"]),
            …

## Contribute

PRs are welcome and DMs are open at twitter.com/notcraigwright.
