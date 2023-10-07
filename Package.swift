// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "secp256k1",
    products: [
        .library(name: "secp256k1", targets: ["libsecp256k1"]),
    ],
    targets: [
        .target(
            name: "libsecp256k1",
            path: "src",
            exclude: ["asm/", "bench.c", "bench_internal.c", "bench_ecmult.c", "ctime_tests.c", "tests.c", "tests_exhaustive.c", /*"precomputed_ecmult.c", "precomputed_ecmult.c",*/ "precompute_ecmult_gen.c", /*"precomputed_ecmult_gen.c"*/],
            cSettings: [
                // Basic config values that are universal and require no dependencies.
                //.define("ECMULT_GEN_PREC_BITS", to: "4"),
                //.define("ECMULT_WINDOW_SIZE", to: "15"),
                // Enabling additional secp256k1 modules.
                .define("ENABLE_MODULE_ECDH"),
                .define("ENABLE_MODULE_EXTRAKEYS"),
                .define("ENABLE_MODULE_SCHNORRSIG"),
                .define("ENABLE_MODULE_ELLSWIFT"),
            ]
        ),
    ],
    cLanguageStandard: .c89
)
