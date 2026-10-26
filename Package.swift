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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.22/SiriusMarkdown.xcframework.zip", checksum: "416b7e508302c485a6c618bb551dec2eb906505e0387d428a5196e67cde77eb9"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.22/SiriusMarkdownCore.xcframework.zip", checksum: "0d50b967de9cec8db21308387e3a87dc684a1f40a3fda13bd875e9fbcdf9d4ef"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.22/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "cda6d679277ca1278f3d443c788154b83e378c031332840db39dd0bba8f0b585"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.22/SiriusMarkdownMathEngine.xcframework.zip", checksum: "eab0725a9e2ac657946c9eccf11857a68fcd9b943f48e53eb0175a1475d23c43"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.22/SiriusMarkdownMath.xcframework.zip", checksum: "d9805825f36d83cc967bb41837541ec664cc662b7a2009aefdfb5984172a97c4"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.22/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "d7f390ff90e8b85fa39551ce1a3ea67c8c35ff57a8f54acbed6823d27f0d209f"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.22/SiriusMarkdownQuickLook.xcframework.zip", checksum: "5b88fb81da45cf572db4cc00ad872399d0bf45dd8ed803c029617ce4d4500eb4"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.22/SiriusMarkdownSupport.xcframework.zip", checksum: "ff9af67d12767ac7bcf6373c1bbdd831a151835d17636a795f3251cc4f60280e")
    ]
)
