// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "SiriusMarkdown",
    platforms: [.macOS(.v13), .iOS(.v16), .visionOS(.v1)],
    products: [
        .library(name: "SiriusMarkdown", targets: ["SiriusMarkdownCore", "SiriusMarkdownSupport", "SiriusMarkdownSwiftUI", "SiriusMarkdownMathEngine", "SiriusMarkdown"]),
        .library(name: "SiriusMarkdownCore", targets: ["SiriusMarkdownCore", "SiriusMarkdownSupport"]),
        .library(name: "SiriusMarkdownSwiftUI", targets: ["SiriusMarkdownCore", "SiriusMarkdownSupport", "SiriusMarkdownSwiftUI", "SiriusMarkdownMathEngine"]),
        .library(name: "SiriusMarkdownMathEngine", targets: ["SiriusMarkdownCore", "SiriusMarkdownSupport", "SiriusMarkdownMathEngine"]),
        .library(name: "SiriusMarkdownMath", targets: ["SiriusMarkdownCore", "SiriusMarkdownSupport", "SiriusMarkdownSwiftUI", "SiriusMarkdownMathEngine", "SiriusMarkdownMath"]),
        .library(name: "SiriusMarkdownPretextSupport", targets: ["SiriusMarkdownCore", "SiriusMarkdownSupport", "SiriusMarkdownPretextSupport"]),
        .library(name: "SiriusMarkdownQuickLook", targets: ["SiriusMarkdownCore", "SiriusMarkdownSupport", "SiriusMarkdownSwiftUI", "SiriusMarkdownMathEngine", "SiriusMarkdownMath", "SiriusMarkdownQuickLook"])
    ],
    targets: [
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.9/SiriusMarkdown.xcframework.zip", checksum: "54f638d2127c7ed8a3e4135afa51aeaf4b11f14cb1d651a386ceed7b6432e902"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.9/SiriusMarkdownCore.xcframework.zip", checksum: "9531748597802082fad2b9d95e3508c2ddb74415bc18644469da7d2ec214bc58"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.9/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "8b6d82d801bc3ae488c4d09e0c335223d4e25b9feabd1c6daa7a1fd73cc5d79f"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.9/SiriusMarkdownMathEngine.xcframework.zip", checksum: "e892be523b2833ca060162f9978f2795269425d3cc1868c991e75698279175a5"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.9/SiriusMarkdownMath.xcframework.zip", checksum: "7db920742d5eb1c99edf46e8eb598e5f17ce59325b30f1abe496d58732a42d0d"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.9/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "252afcd826b92461bd4f65f9eb820bb2834631119026e4f2c3946f406552b7b5"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.9/SiriusMarkdownQuickLook.xcframework.zip", checksum: "5af2ded5f5485c460455e43a9fd06309c24fef86967d0352d14385a43d5e56d3"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.9/SiriusMarkdownSupport.xcframework.zip", checksum: "67d1b9dfca3af2a812d6e8e1758badc62edb7bd58e4e1272844190d8db637f15")
    ]
)
