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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.24/SiriusMarkdown.xcframework.zip", checksum: "ce9781682ffcd59f4b5ef4587845759bc6e02bc66c7947de4c9b2f386523349c"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.24/SiriusMarkdownCore.xcframework.zip", checksum: "02f8b5365925e60113a30f4fdda102372a42cb19895b71ff2c3c2693cf9e4ff4"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.24/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "b091a77817258fe18bf2efae6e017f9a92114e846d770027c00e4dd51178051c"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.24/SiriusMarkdownMathEngine.xcframework.zip", checksum: "dd07715ef1e02f606e8545dcad2b37d1f0427f48f1647bcbed4e9e025043aa83"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.24/SiriusMarkdownMath.xcframework.zip", checksum: "38b3a0a0fef3014116bd33d746d6fcf9814535b26b8938ebcc83c20093b49f8b"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.24/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "606ab04bc2a088ec6d77042ca2793044595eb015f4a9409e6ee6329773b40665"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.24/SiriusMarkdownQuickLook.xcframework.zip", checksum: "98e1016772a4e2912a6f1716fa72ab0228afcfd255d53e2174553970c18f4b00"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.24/SiriusMarkdownSupport.xcframework.zip", checksum: "613460a6d295fd23c663ebca00cd598ff9e705b3ae5e9eac2491bdedf34f82d3")
    ]
)
