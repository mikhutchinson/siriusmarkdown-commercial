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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.16/SiriusMarkdown.xcframework.zip", checksum: "392784cc6f6fa8004a2ee9466fb6d062545a3baf5cf2da99fc09ae1898f3b70a"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.16/SiriusMarkdownCore.xcframework.zip", checksum: "6a899758c4bb806cd2b17c0a0d3bc1a829a6da8811683969498b6b3bf318621f"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.16/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "5192242e232f05149056cd204b956db884e9bfb31b13654d1ee143f94833d6ab"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.16/SiriusMarkdownMathEngine.xcframework.zip", checksum: "a241de72e609168710e8994db7d5ad05925a5d139043a762e61bf6a1f1c3a99e"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.16/SiriusMarkdownMath.xcframework.zip", checksum: "b31ee41c2826c25cae1491269db8567ec230b6e32cbbdacc8db59a74b2a3909e"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.16/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "b09217812964ff3b53b7133a6f87c993109c01ad6314d8451ba022507e7714a3"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.16/SiriusMarkdownQuickLook.xcframework.zip", checksum: "521f1757a7e3875b166019d30209a5b0153bddddbf3bd32d7ff0511ee93cf61f"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.16/SiriusMarkdownSupport.xcframework.zip", checksum: "3cf8f92ae27352574eced7d88534ad457961930dc75c890390a88c44f1609cc2")
    ]
)
