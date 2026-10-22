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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.12/SiriusMarkdown.xcframework.zip", checksum: "057827a08d805241a5017a64494c349511c8dc72bfdd57f974bbcb63a9f07bd3"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.12/SiriusMarkdownCore.xcframework.zip", checksum: "117d31be4f3ad59d3cfb0c47e06f8d2e9e6e6028522ab6091264c06e4610ab47"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.12/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "f65c4c365431f88ee8dd1fe0624e8ef4c99f8b8d55ddb691bf941390b9475b58"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.12/SiriusMarkdownMathEngine.xcframework.zip", checksum: "7ad1abebcdbcf3e60cf0315678c107184e56b5992cbe7b5ce26196418460d411"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.12/SiriusMarkdownMath.xcframework.zip", checksum: "bdf94bfeaef91b993ad3e4ddffc5812c16e71e16a4cb377f4a759c2c22e585f0"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.12/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "2e725108ff6fd2f6a0b634f7dba65897b0a52893ef0398c3e52aca5d187c674a"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.12/SiriusMarkdownQuickLook.xcframework.zip", checksum: "200d136c1340754fbf446f7e3ebdf3dbf8de8cf1a5bd477490f798a82d07d0f2"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.12/SiriusMarkdownSupport.xcframework.zip", checksum: "f052a493b48b8a2181261be5ebc7a48115bdfd6ad9e60288762dbded8c2630a4")
    ]
)
