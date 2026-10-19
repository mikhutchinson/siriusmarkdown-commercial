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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.7/SiriusMarkdown.xcframework.zip", checksum: "c6fdb0a037dc623a27d456f5c89f11adec6eca0b7733ecfad76f2de2ed6db1b5"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.7/SiriusMarkdownCore.xcframework.zip", checksum: "32b87f4bc8800860e2c57beb725be7f074e29e3e1a7c5c794bac5123ae8a86be"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.7/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "36c677217ac802fa5bb2e809113aa1ced095cc273311ab40e8e3d4f904aed0b2"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.7/SiriusMarkdownMathEngine.xcframework.zip", checksum: "19965015c5b5e8a86438141a0ce91d6c32bdc12283ae8c2576bc954278231c8d"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.7/SiriusMarkdownMath.xcframework.zip", checksum: "b166b9d7e1da099df7a63e15f36ad73b7ed88a07463c29099132bbbb9b439a93"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.7/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "64710b9e0dfef5aa68c81323692b27ebb4e1c6e2672a8f91f8fb29bf03472574"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.7/SiriusMarkdownQuickLook.xcframework.zip", checksum: "8be8de92bcd32d379d38121c7f59d5bfa0583957da50c8cfb52476058898efab"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.7/SiriusMarkdownSupport.xcframework.zip", checksum: "6e9c06dc186b1a6b7d8925f4a0d957860589d07509a4cfb62b6aa240b4ee26c4")
    ]
)
