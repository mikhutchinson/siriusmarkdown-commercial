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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdown.xcframework.zip", checksum: "2e202a6d36106dfeeeec486ec335006d8d20935bf232be1ca0c285704a80d664"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownCore.xcframework.zip", checksum: "b0cabf437a0817421bbb583d9b50bde069e4e09942c7248780d6f1988aa0e6e6"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "f728f0f8abeef24107c828ce5ce156293259960e09bcba64996c1af0c1605797"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownMathEngine.xcframework.zip", checksum: "e5c5d1edef686b334e22eb23f1571b695d2e2e5bb7847d82b10ee128adea785b"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownMath.xcframework.zip", checksum: "5f1829a2149e035fd072f95772662b1288e49f778ac54376e112be6d0372f1cb"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "bd7041fb0b277e362c1d2fe80223ef8d82ad061d1581b5425ecae45ede1e6597"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownQuickLook.xcframework.zip", checksum: "2815e2bfbc99712516ed15a483270adffbd9bb6b2c7b7f730cfb192452db6397"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownSupport.xcframework.zip", checksum: "f9d4f64778c35b6714e4eb3c3fc97e81969d0efa74f30eb780ea62f965138a47")
    ]
)
