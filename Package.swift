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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.5/SiriusMarkdown.xcframework.zip", checksum: "cdce7f1cdf03a950d5032d7d16018a51efcd6afee5396268d5eabc9f30d17dba"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.5/SiriusMarkdownCore.xcframework.zip", checksum: "0e1609a728644e56212cd7d077796f0f289b011152a218de45b8a16959f1b5ed"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.5/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "bdea26673fdc989c4a20d41e06a49cf6624abd4b91f9111fdf45947936f71fb9"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.5/SiriusMarkdownMathEngine.xcframework.zip", checksum: "8d3922a8485c2c26c042683ddaa1daae29104d413328978f5865d4d73bd2892e"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.5/SiriusMarkdownMath.xcframework.zip", checksum: "36269442902246c270d572cd2472821016ac0755a96abd344de41251d802139c"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.5/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "19471a90129490553f06c2aa539d5b503aa32bb88b99c5b68fdd9260b8e82a49"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.5/SiriusMarkdownQuickLook.xcframework.zip", checksum: "80218ac6fcb64c13b61fb2e381355d4b43dbaef5443aa31ba144473f58c1385d"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.5/SiriusMarkdownSupport.xcframework.zip", checksum: "9b3b456c1a7f1559363530f6d9db3edcc77a582a0aa80a12be51e75e7451ce2e")
    ]
)
