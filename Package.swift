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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.8/SiriusMarkdown.xcframework.zip", checksum: "155d26e718698ca39d2fdf6b5def396008f70fab32a5bfc47550868d8b0927ae"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.8/SiriusMarkdownCore.xcframework.zip", checksum: "a51c53b004050139b3bb7ddf688f869737401398e56563d1dd4c8d4e580a59f3"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.8/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "b846b8b9ce5526156aa3a366200edf4a5dfad879df81fbbd29086baf41f6ad54"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.8/SiriusMarkdownMathEngine.xcframework.zip", checksum: "a1371d69061cbbf2500f97e5a0c2d22ec4024b7fb59182996d4f453fe6a6c0b1"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.8/SiriusMarkdownMath.xcframework.zip", checksum: "afc90476ef44f320ba986793c0de11627b7f616eb99c6ba7753124c1ddec3039"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.8/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "d2c21c420d61ccda8f388ec92c5564a08b165c9493db5042ad2de4cf5ea2995f"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.8/SiriusMarkdownQuickLook.xcframework.zip", checksum: "563444f4615606f240510e72e48dd4ac09fbc2eeb7780dc8d8188ebd982023d3"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.8/SiriusMarkdownSupport.xcframework.zip", checksum: "305cfbd61d0c3d2966e2a1829a5c236a641b462e5139e6a782442eaca524436d")
    ]
)
