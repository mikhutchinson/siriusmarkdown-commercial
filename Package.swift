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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.4/SiriusMarkdown.xcframework.zip", checksum: "4499757d508f62c30406eb305848d3b90b7cce84fbe70ddbf76ef3198108cfb2"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.4/SiriusMarkdownCore.xcframework.zip", checksum: "15c45cb5a1959df47d16f4c8f0d6555e96cc70ab3e83545d41564dae8012ecce"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.4/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "c13be9e6f17431baf3e3fcc30119a21a45a444fa47651d631327d6e56e791f4e"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.4/SiriusMarkdownMathEngine.xcframework.zip", checksum: "87dc522f745fe88714d241422af7aa2219e04e4a2c43dea8b685a4255f1eb07e"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.4/SiriusMarkdownMath.xcframework.zip", checksum: "b249a4a3025c9e26758127e72794637b56c277500a57d4dedca76dd4855c3066"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.4/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "9a444eb6ef3a6ed4bc56cb78ea48a55c8ccd09c8b4a07f88729a40293649bd79"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.4/SiriusMarkdownQuickLook.xcframework.zip", checksum: "11852e11b52b41ed5ac9b6cebf61b1efd3d8ec57c3e26d4e78d0a2d7adea13bb"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.4/SiriusMarkdownSupport.xcframework.zip", checksum: "11160711c4296095e5135c01ff97e8f6dd82282a33e7d79d6042808ad01f3697")
    ]
)
