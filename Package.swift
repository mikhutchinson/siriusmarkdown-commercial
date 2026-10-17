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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.6/SiriusMarkdown.xcframework.zip", checksum: "f7556144a8d79d41f87a7d0deb3c0cafa33d65f3cbe5aa2b35c4c86358cde421"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.6/SiriusMarkdownCore.xcframework.zip", checksum: "4ef6079f2bd7b2421d055aad7afac53f1052480a2ce05ece832c0fd0a84fc6c6"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.6/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "903a7feb712ffd59e23befae7131dcd74c9a36bba4f2b6e524843af6081580e2"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.6/SiriusMarkdownMathEngine.xcframework.zip", checksum: "60ae034d945aa988cb3f7f95701f8ec8a84deb37a9ed123a101a59464ab7a924"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.6/SiriusMarkdownMath.xcframework.zip", checksum: "5419490ee4e341b3ed21b57e37cc28671df1596479eb51e51d9670c6e3d56877"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.6/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "045ef48da4f628d79c7ebf9d20b6e9502f1ddce08a45cd5cf71b7a59b4f632b9"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.6/SiriusMarkdownQuickLook.xcframework.zip", checksum: "f10399faa042c7163ab3d15817186b2039cff93bb43ce78e9bdb404ff7ebe5aa"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.6/SiriusMarkdownSupport.xcframework.zip", checksum: "b54c2e0a59c3bbab6b1574e937c5c8131e3e78e6346a22257e23749f9a8266e9")
    ]
)
