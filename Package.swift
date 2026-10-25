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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdown.xcframework.zip", checksum: "a5a1154150b38e8a3f0696445ebca86d089c851c079ea132e33bced1b3fb41c3"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownCore.xcframework.zip", checksum: "196878cfc02eb0376f3fdc04c0cef9f7841165e8041f4d8b1348ae3c18e23594"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "d4635fa9dec317145cd55af626acae5443cf4efefba2f6f07405d3abe311bcb5"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownMathEngine.xcframework.zip", checksum: "54ec9bb1bc3470a4250848df1673fa8b9b8fec0629314f324a748bdd3bcc5b10"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownMath.xcframework.zip", checksum: "2f577f591e00c7d2b79a0a4ada4724536d5c527e7f3fc5f86455a965d74a4d01"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "05488fc7d9d9b9ac7d4ce7581fddd50809ca1c2d67c0a61a70a565cd60d82673"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownQuickLook.xcframework.zip", checksum: "e522903c9c82f25b7544a4448a00f9eae670e68171b4c9a28a27248ebe0ba7b1"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownSupport.xcframework.zip", checksum: "999be14aedef5c0bb3c0b1e1be2b5f23bd70cc044aed44a2fb538cd024ea7e13")
    ]
)
