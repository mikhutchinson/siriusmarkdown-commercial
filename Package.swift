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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.13/SiriusMarkdown.xcframework.zip", checksum: "d47b25c1c586245008e5d9a48214bb0e43d4e51d90efedc1c70b563273a04dfe"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.13/SiriusMarkdownCore.xcframework.zip", checksum: "5189f4eac4dffd59c44a868c43e38ec933c7f80f93dc6c79a0220cc679176be6"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.13/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "8928428b08acf9990caa1330eb7b49aac1d8db4587191c4337b88ddf2b1baa90"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.13/SiriusMarkdownMathEngine.xcframework.zip", checksum: "7f7005c1a1cfbc503407e3d1c3c421f72437387eb55d41e6d1c694d7e372d1e6"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.13/SiriusMarkdownMath.xcframework.zip", checksum: "53bdacdf96d342bb274915a49d5f7ddba4d2563fb2981928d1e769185b4ebdd8"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.13/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "4dd0d97f7eb78342583dedaf90c4386b1f8821d31a0180ef6cdf16f696d6fdb7"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.13/SiriusMarkdownQuickLook.xcframework.zip", checksum: "6f4e07c023e8e54546f27f50a671f0c82aab36bfcc04000796754da36165e70e"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.13/SiriusMarkdownSupport.xcframework.zip", checksum: "e6d37c6839a6968f7ff760e7bf1aae7faa2e983525bc2123b5ffe295c831ba99")
    ]
)
