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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.15/SiriusMarkdown.xcframework.zip", checksum: "db41f0dc1a56f43ca878653e08f5d3537c2b01a55f9f3f39f3cbee13ce2615f6"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.15/SiriusMarkdownCore.xcframework.zip", checksum: "58643b0f0a335c2cd7f60e7815f41a9f71dbdfcc928b8eb30f9b2c546b75c595"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.15/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "0a3ce25e93e03b18a76ceaf351b21eb3411446fcb4da977f7c5188a22da140a0"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.15/SiriusMarkdownMathEngine.xcframework.zip", checksum: "e5e57a854e69c38eb7c4e573440d0da03baa1b1270304e6bfac4ae9dce1211ba"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.15/SiriusMarkdownMath.xcframework.zip", checksum: "f71e04220bbcbc86779731c638e9f116df104fdfbaac0a4bfb559d5a30abd16a"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.15/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "765a41a24dbaac8856725d93358e4b6fa34851bfccd7ae8450636ab021136640"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.15/SiriusMarkdownQuickLook.xcframework.zip", checksum: "75fdd26b791bb6773acb198f40f2668221d5b4386b4fe3e15941835c7513cc1c"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.15/SiriusMarkdownSupport.xcframework.zip", checksum: "4b36749556771c393743c3d96d078c3b56b74952d28a28119175ddf9733588b1")
    ]
)
