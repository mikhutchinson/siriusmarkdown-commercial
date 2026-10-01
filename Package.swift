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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.0/SiriusMarkdown.xcframework.zip", checksum: "190bb9ceb4f946be113c5d7da9ca5f3434e6dfe0211183398d2a42f8aaa97e0b"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.0/SiriusMarkdownCore.xcframework.zip", checksum: "30732ec61da0b8ade3e9193e08996d197aa193ac22b340f101f542e3e1ddb56c"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.0/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "43f93532087a4b2463e3b7c2b2f867886a4a9b329cf01dfa3ed2b28df1d28b75"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.0/SiriusMarkdownMathEngine.xcframework.zip", checksum: "21ef0aa938ea796005fdb716796362c352977e5abf70844a542fbd32c3b59eea"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.0/SiriusMarkdownMath.xcframework.zip", checksum: "e207cb9f31c80b03b159a953f10e0e0bf7741030014178fbc1f228f7a83f1503"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.0/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "64d62df1e4c3d7fab510820527510fb8bcb5efeef1bb0913819d6bf9994a2174"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.0/SiriusMarkdownQuickLook.xcframework.zip", checksum: "09af99a0881bff09114eaaf044b75c03a932ca1e49bc4070533225ff85166982"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.0/SiriusMarkdownSupport.xcframework.zip", checksum: "bbbf9c86d413f64ad004c16b70688ca19ca959a2cd5db034972d9713d9f37e05")
    ]
)
