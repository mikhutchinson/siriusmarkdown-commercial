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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdown.xcframework.zip", checksum: "c6d9d8fd66505aea80e30aa0e64e054fb20e37a814aab8625b246442b3c32343"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownCore.xcframework.zip", checksum: "22e5b56294bacc86f734cca9a9b7b29b3fa5641b3860def304b6cc878131f8aa"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "c305e4b54502801dc00a4c5ed2abc2031a100fc38d5161bc10b304b567dc4ecc"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownMathEngine.xcframework.zip", checksum: "9129d350de0f5ad4f03158e4c3a96fa4a31e4003227f7f1ea5533837f6b50f1c"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownMath.xcframework.zip", checksum: "18fcc1ad53059ad4adcf05f6d8a04c9f765b8ae2e9106abfe8e984b8922c643a"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "e3756e5d34a6821064e292c87572562eec1fac20a3189d9545042197d2c719f0"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownQuickLook.xcframework.zip", checksum: "d387733da5d9962811a451150e94950990e0d7eb8d85f6db5e53b239e9f53640"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.20/SiriusMarkdownSupport.xcframework.zip", checksum: "435236551e53cfaaf8fb5fd4100d0c05a0e81f0583dafcc5c9cacc109e588db8")
    ]
)
