// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "secp256k1",
    products: [
        .library(name: "SECP256k1", targets: ["SECP256k1"]),
    ],
    targets: [
        .target(
            name: "SECP256k1PreComputed",
            path: "src",
            sources: ["precomputed_ecmult.c", "precomputed_ecmult_gen.c"],
            publicHeadersPath: "include-precomputed",
            cSettings: [
                .define("SECP256K1_BUILD", to: ""),
            ]
        ),
        .target(
            name: "SECP256k1",
            dependencies: ["SECP256k1PreComputed"],
            path: "src",
            sources: ["secp256k1.c"],
            publicHeadersPath: "include",
            cSettings: [
                .define("SECP256K1_BUILD", to: ""),
                .define("ENABLE_MODULE_ECDH"),
                .define("ENABLE_MODULE_RECOVERY"),
                .define("ENABLE_MODULE_EXTRAKEYS"),
                .define("ENABLE_MODULE_SCHNORRSIG"),
                .define("ENABLE_MODULE_ELLSWIFT"),
            ]
        ),
        .executableTarget(
            name: "SECP256k1Tests",
            dependencies: ["SECP256k1PreComputed"],
            path: "src",
            sources: ["tests.c"],
            cSettings: [
                .define("SECP256K1_BUILD", to: ""),
                .define("ENABLE_MODULE_ECDH"),
                .define("ENABLE_MODULE_RECOVERY"),
                .define("ENABLE_MODULE_EXTRAKEYS"),
                .define("ENABLE_MODULE_SCHNORRSIG"),
                .define("ENABLE_MODULE_ELLSWIFT"),
            ]
        )
    ],
    cLanguageStandard: .c89
)
