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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.2/SiriusMarkdown.xcframework.zip", checksum: "a5d9893e15a594304610726dca56e53dc6a833c3ca4d6771247b973dfa9b7f84"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.2/SiriusMarkdownCore.xcframework.zip", checksum: "417f3d3b8b32aad636d501d48c7706eac7c5b2c0731518b65655efbeb6ce9dfa"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.2/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "cffc3040bb5bd1adcdacc4161de0cc43c1f539f757fb6ca5199131ce72fbf90c"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.2/SiriusMarkdownMathEngine.xcframework.zip", checksum: "3e489f1c8fab987476a7c2a36c09ba5f587d32fcd62bab7bc9ea03bbbd17914d"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.2/SiriusMarkdownMath.xcframework.zip", checksum: "c7d65390e411fb13f1771b38498d171584c053ab1c8481fee33bb72c40d6fc97"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.2/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "dab40d59d0bfa8fca0869330c24ad14c311a980b06240a91bfbe83c2f5f2bb0d"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.2/SiriusMarkdownQuickLook.xcframework.zip", checksum: "eca1d9757a59292bb7ec1666714466d8002098b3c7930f173f7ce0848e2ca420"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.2/SiriusMarkdownSupport.xcframework.zip", checksum: "dbb52c173143023770fa4a00943b86022900d0ba89f6125454e72cbe87a75fc7")
    ]
)
