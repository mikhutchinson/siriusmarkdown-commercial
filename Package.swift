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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.26/SiriusMarkdown.xcframework.zip", checksum: "06f492f371c075fffdb902549a967794195c02bf663452e997b3c61b7d2bb500"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.26/SiriusMarkdownCore.xcframework.zip", checksum: "b1128c3ccdcf3e64dc944ab3db107d71fa9235ac38035e56b974f2b5a536ca60"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.26/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "1be5c8924d824ec46738510bf9bcfb3e8abf161ed0ff11aea1e66014a6aabc2b"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.26/SiriusMarkdownMathEngine.xcframework.zip", checksum: "45f2d4a685c98654cd60c69f82979c8f2870cc2df0231333bbd2a390ea7d333d"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.26/SiriusMarkdownMath.xcframework.zip", checksum: "c3bb7c671f2189a86675e577b38c34d9a2d126a5fab2b9c27bc65c0d66992c40"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.26/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "7f7ec885818ee7a258617bb59233af374caf86dc78fbd4a0fc833be9fae26959"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.26/SiriusMarkdownQuickLook.xcframework.zip", checksum: "732343ba140d9efce116fea62567aebba85e354b7651c1f1e89457f56533cc7a"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.26/SiriusMarkdownSupport.xcframework.zip", checksum: "101c5354b26143a7d1fb0ff8f64edb88be0fc324197909d16258eab35a8d54ce")
    ]
)
