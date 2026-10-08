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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdown.xcframework.zip", checksum: "be25ffb87f5b00aac379439748c2cec32877bc217c2e03f3f05f661270b5a84d"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownCore.xcframework.zip", checksum: "3d948594bd51dcc26bba3140b8adddecdccc6dff218ca503f245b89f4cd27c4b"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "92734623f007e0e64ed012198f6d0baa26c165a159e8a1e17a4e067d22e5c17a"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownMathEngine.xcframework.zip", checksum: "326a3e17f010f8ca3007d10bd517b1d61f56baaae0efaf4f13a3cb67a00ff205"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownMath.xcframework.zip", checksum: "db10cbc270c74d12e56e002ebd5747961511baa5b1de6316af5842c896dc9503"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "9ae4313cc8fe3c70e9cead2555d3bc50c9da27e9e11b787448304b7f51c9c6ac"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownQuickLook.xcframework.zip", checksum: "a7779dc931f61f043e3a03ba4883b846e6a7d87218c45d1947f7ddab72720b6e"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.3/SiriusMarkdownSupport.xcframework.zip", checksum: "a7ef0999d11ff96514ffba5594847902c5ddc63747d65e089b1357c10b2e02bf")
    ]
)
