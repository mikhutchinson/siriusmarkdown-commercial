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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.23/SiriusMarkdown.xcframework.zip", checksum: "4821731231865728a3387a2561630083343eab2004c8f9378c288bb4e9dfa842"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.23/SiriusMarkdownCore.xcframework.zip", checksum: "0584d1a3e07346ab169ba1435d39e3ba1684d41bc6f49d57b428bb32efaba47f"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.23/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "42f93fd757c06b23f8e7d183aa983fa53edae846fc6e32f94d3e43b4dd631f8e"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.23/SiriusMarkdownMathEngine.xcframework.zip", checksum: "07f4661f8c8d83ff038b261b666d5ebd40f550897b10e56a6691cb0b35ab799f"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.23/SiriusMarkdownMath.xcframework.zip", checksum: "9e46d95391c63d1dcbc93c611b1c974e379d2e5338e0016a2f2ac14af9b3d803"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.23/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "5013d08f28040fe2e5320781860b45952278f1cdf69774f3e12224145ca4c1a3"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.23/SiriusMarkdownQuickLook.xcframework.zip", checksum: "089f2e7e995804eae9e4103fffc8de9ffa7783cdbaa6bfb89d0a26c4bfc4433d"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.23/SiriusMarkdownSupport.xcframework.zip", checksum: "25d914be80d20c4c0eef2ec84d3488d7ef803cfb17181b311102dd8f1d061ed8")
    ]
)
