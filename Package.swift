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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.27/SiriusMarkdown.xcframework.zip", checksum: "5cbd51b7420eb33a03ff876bc5327de9b7d2ba2da8c500bd7d6bcf4e00b6e398"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.27/SiriusMarkdownCore.xcframework.zip", checksum: "548b788428f58ffd9d47610f3079a3d07f25608f7eb2811ed254f8a79e1a1189"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.27/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "cc880f621b8e5d45f20421f387ea91152351f7dad80a21dc9cb60f5da7bbadf1"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.27/SiriusMarkdownMathEngine.xcframework.zip", checksum: "f8af24ba019de620bd535ebe04c736838071034bfeedc23c6a8e721e8871ad3c"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.27/SiriusMarkdownMath.xcframework.zip", checksum: "f46e0ea575cea0301318dabfedf8941e16412292ed173809b4a1e7c9453c804a"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.27/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "f9e60c1a0ae1bbcc1926b53e0c0dc6d7812dc64e73d6ed6660a36f86c6882bd3"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.27/SiriusMarkdownQuickLook.xcframework.zip", checksum: "099e921253bf3ad5e94638e6b47f143fe3684a8675d17d73a22b9101a728b690"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.27/SiriusMarkdownSupport.xcframework.zip", checksum: "59857f0f6a236e060f1b2f6b860f32ef5cf381720bb75c08a5186cf76d44e1a0")
    ]
)
