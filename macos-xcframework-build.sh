#!/bin/sh

# Dependencies: autoconf automake zip

set -e

./autogen.sh

# Optional MACOSX_DEPLOYMENT_TARGET=12.0

./configure --prefix=$PWD/dist.macos.x86_64 \
    --enable-experimental --enable-tests --disable-benchmark --disable-shared \
    --enable-module-extrakeys --enable-module-schnorrsig \
    --disable-module-recovery --disable-module-ecdh \
    --host=x86_64-apple-darwin \
    CFLAGS="-O3 -arch x86_64 -fembed-bitcode -mmacosx-version-min=12.0"
make check
make install

# Set the CPU architecture for ARM.

make clean
./configure --prefix=$PWD/dist.macos.arm64 \
    --enable-experimental --enable-tests --disable-benchmark --disable-shared \
    --enable-module-extrakeys --enable-module-schnorrsig \
    --disable-module-recovery --disable-module-ecdh \
    --host=arm64-apple-darwin \
    CFLAGS="-O3 -arch arm64 -fembed-bitcode -mmacosx-version-min=12.0"
make install

### Creating an XCFramework

make clean

rm -rf dist.macos
mkdir dist.macos

lipo dist.macos.x86_64/lib/libsecp256k1.a dist.macos.arm64/lib/libsecp256k1.a -create -output dist.macos/libsecp256k1.a
xcodebuild -create-xcframework -library dist.macos/libsecp256k1.a -headers dist.macos.x86_64/include -output secp256k1.xcframework

rm -rf dist.macos

zip -Xr secp256k1.xcframework.zip secp256k1.xcframework
touch Package.swift
swift package compute-checksum secp256k1.xcframework.zip > secp256k1.xcframework.zip.checksum
rm -rf Package.swift
