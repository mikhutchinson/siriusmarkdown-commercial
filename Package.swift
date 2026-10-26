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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.21/SiriusMarkdown.xcframework.zip", checksum: "313b040676a07645817cf47d4fdeea915ee18d2273c678a0f43c2069e28a093d"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.21/SiriusMarkdownCore.xcframework.zip", checksum: "81c51364b5ef786f7ed96b7364ab5d439c5170883ee69e737946623fddbb473e"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.21/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "19541c572a0b3c1684de49b89aaa51aba2c8b9f1bd33143c5dcf76668c73eee9"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.21/SiriusMarkdownMathEngine.xcframework.zip", checksum: "ddab54e63201eff02b775396e4c44d4854d900650acc4523b05c8ba1f6babae4"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.21/SiriusMarkdownMath.xcframework.zip", checksum: "8f47a31a9e6abfbd74c3fe3fd9fc1d35a3df33f3d63d3405a61f04f9160583e3"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.21/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "8de20df9f3488b42c50fe9fcb05d668da185cbaa523e7a7fb9499bf3d4033cad"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.21/SiriusMarkdownQuickLook.xcframework.zip", checksum: "be3b1bbcad0683492743b17c3f0c8478b09a606116e7cb14d06ffcb03c9cf9d3"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.21/SiriusMarkdownSupport.xcframework.zip", checksum: "a3ceb13163441ae598fa0fc40b60bbca24c7cd13f1bb7ffd5d889eab05ce0d96")
    ]
)
