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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.28/SiriusMarkdown.xcframework.zip", checksum: "07205b512fdf8faeb32c90bcc372d028bbeff5dc66345f6fa4cec3413ddd5ec6"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.28/SiriusMarkdownCore.xcframework.zip", checksum: "8f9b99af5ec126fbe78bdc2d689782388cdee997879ff2b330871ef0a8b39b03"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.28/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "96837fd55b98b4de8d75b0aeee9764db993abdb441e243ed2ab900c665fc9856"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.28/SiriusMarkdownMathEngine.xcframework.zip", checksum: "5b2d58e2d5890522def48da8de1513d9f00364dd4e5525df2e857bc13d41998f"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.28/SiriusMarkdownMath.xcframework.zip", checksum: "892ddeab95a01e45463fe165e8e8d5b725606c3a9a3979c8776ff2112e4ee802"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.28/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "0eb9b37cd414c9ceb6427389a4bf7906c84d7651a7dc22216b4ad91550747a2e"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.28/SiriusMarkdownQuickLook.xcframework.zip", checksum: "f5024b4c42a2cadcc4f77b5864a329132e3164be4c64946c3e5c6963da7324ba"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.28/SiriusMarkdownSupport.xcframework.zip", checksum: "ee0614505ecd0d220cef2eeb49aba56ea8977d1cd8bcdff3caf9cb121abd0ef9")
    ]
)
