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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.25/SiriusMarkdown.xcframework.zip", checksum: "29baa346e88ca7e6df514be66a3ad24060c2fdc60e2ff6320318b017918055e6"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.25/SiriusMarkdownCore.xcframework.zip", checksum: "6d636d20a6318da8fa72790d5ac54256b7635277895c817571f91e2643db53ba"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.25/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "cc5635d02da80caea372ac7677b84c31b477ef07d570c2ebcd969dd721834769"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.25/SiriusMarkdownMathEngine.xcframework.zip", checksum: "60540e2748c5177b7a6b6d26268adaa7b3181f7e519bf8a6576120fd54a09ef2"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.25/SiriusMarkdownMath.xcframework.zip", checksum: "4a087768f3b10b66312b5b964fd29f5ef3ba24fb69e88ea006b565a90cf3a4f2"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.25/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "b5654d7d5e44a8e05392d9b494ae1065026d3cd93115f7dfbd58e6e6813c1799"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.25/SiriusMarkdownQuickLook.xcframework.zip", checksum: "c134a4e3f6837e9c6b3a607af361f03a7806c9fd606febe012cd561a9ed11233"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.25/SiriusMarkdownSupport.xcframework.zip", checksum: "92610dcfc8fa65bbae7f0f8035f5889b67a75ffb8e33814f845e6afebf2ee3e6")
    ]
)
