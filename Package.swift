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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.14/SiriusMarkdown.xcframework.zip", checksum: "c15cbcf4818d9ddafda28b5bcf9a8a1f9c53023b265293ae1ab5bf6a45ceef7b"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.14/SiriusMarkdownCore.xcframework.zip", checksum: "ae646a35447c86ab71a7c407fde1947a35853ec328832be9004c24484f86e9c8"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.14/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "24f78c7809bb14e654cd7ec494d5f7eda8c59b7fe9d60c24ae329a8ed0b2febd"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.14/SiriusMarkdownMathEngine.xcframework.zip", checksum: "72d81fcf1eafedb66d19170d1d2971eb5dad8f3ceb26095d9eb9d5a7a82f0243"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.14/SiriusMarkdownMath.xcframework.zip", checksum: "c9724bad23a3f2df99e8f88541bae7417fad5cf009fc81b2175b0ef449a20a3f"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.14/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "645a13493e664ba64ac244dae0f35f6fae619c8186fa0b507a60b31c978307d6"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.14/SiriusMarkdownQuickLook.xcframework.zip", checksum: "3c10f1f86872c21a80c4fba4a21492385839c6083a57edc7e58e6a955941ee24"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.14/SiriusMarkdownSupport.xcframework.zip", checksum: "029bf5e0b8af12e4e1e6d888b24fdf3bda4cf4a9a08fbb31e6bb21547d58f239")
    ]
)
