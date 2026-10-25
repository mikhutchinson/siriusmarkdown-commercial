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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.17/SiriusMarkdown.xcframework.zip", checksum: "5cb0751ec338e91ec45d0e69a360aef4683d6fc25ef0e8fd9ffc7e3b39358799"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.17/SiriusMarkdownCore.xcframework.zip", checksum: "cb129d5d7d7a45c3571fe876cf4229d04c5d91eecc0c13232a4fed4684b8e69b"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.17/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "a78770913df1023580ca3ccf01ba529b940565eac69a84a45aa6d03a971dd9d7"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.17/SiriusMarkdownMathEngine.xcframework.zip", checksum: "7e5b6ec8ba2574c2674738ed1034e93f5a396b238652e512a2f07b76ff8ffd6f"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.17/SiriusMarkdownMath.xcframework.zip", checksum: "f29f4acf1c21af9eb2166b271e5c1131b41456cbb4b39117cd3ce42ab6a3c825"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.17/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "55d755d0f27c6323e8fd387e16dc7e04fd83502f0eea97cceacc005e05ddee0d"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.17/SiriusMarkdownQuickLook.xcframework.zip", checksum: "f003c857a93f562e9a2fe39d5484a712cb8432bcee0631f8aa0c6c26f9b91e1b"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.17/SiriusMarkdownSupport.xcframework.zip", checksum: "a214064137bb6c884c5296ad397f240e3d42981de10c1fafaff49b2911a3de2f")
    ]
)
