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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.18/SiriusMarkdown.xcframework.zip", checksum: "7bf8a4b32210f391df638293c6f55d2803c2c4a3326f3ecf93958717fbbb5be4"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.18/SiriusMarkdownCore.xcframework.zip", checksum: "6c2f8660d534cbfe5aad2afc0cc351b9a03eba04d06ce1cef3829239018fd209"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.18/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "57ffc6e544d4ce050c92ea2fc2d67afde29117fd1140b0d063afdedf2b8ad968"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.18/SiriusMarkdownMathEngine.xcframework.zip", checksum: "2cd482a8d77970364b1f45b4730e4ac3ba0838575db9ebc1f5da1e638e52a0fb"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.18/SiriusMarkdownMath.xcframework.zip", checksum: "be9ca9a65ab5602f0d87db180e67c3a2b65435b58f6bef79151c4754b14b26f8"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.18/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "cc6c4058bb7cc89257cfdc76bf574a3219a90f0891aa48fb48f83decd4d026ae"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.18/SiriusMarkdownQuickLook.xcframework.zip", checksum: "09328604473fa5bfffd1f8c55b3a72379157f85214a1d564f9a6a778ebcc37e4"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.18/SiriusMarkdownSupport.xcframework.zip", checksum: "56a9970b1ef905f068f4e91527c2b1e784aebd4988f09263d0c8ccca6131d759")
    ]
)
