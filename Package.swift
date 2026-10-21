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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.10/SiriusMarkdown.xcframework.zip", checksum: "333bda1918c9ada60c1a71f01aa193c3f2c64e49391cc328d2ee3debe6cccff7"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.10/SiriusMarkdownCore.xcframework.zip", checksum: "72af5549da8965a585534c99cf2913bebadcd306839502f3801b000b6cbca66b"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.10/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "e1e5090afa075cbf8dcfd4841658611f67bb36de507bc81c10544b5ea545ceff"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.10/SiriusMarkdownMathEngine.xcframework.zip", checksum: "7117866f863b6adf96a6f2d6317b293b3df2eb64bf3effcccd9724b901878f70"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.10/SiriusMarkdownMath.xcframework.zip", checksum: "4fca12d71e2a867b3225e857bb5b91377fa783c65aa78c536c6ab5df3ea79d80"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.10/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "e74e9e08cfd5831de0a943d0727f58b9c27042ca6657876a97314f7a0f7649d0"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.10/SiriusMarkdownQuickLook.xcframework.zip", checksum: "08b070bfb71d707f28f00d853eb1ebcec25640a5031adce18bb168b87d7ece83"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.10/SiriusMarkdownSupport.xcframework.zip", checksum: "9fd758d3fbf5f114dbdefe8740efd59013259f67dec193e3b2ba6e09b67fe180")
    ]
)
