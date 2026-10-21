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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.11/SiriusMarkdown.xcframework.zip", checksum: "05c588687ab85d8aab0d349fc1f30e078aba79d3bb7c2c60e6637aed8dd3d3f5"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.11/SiriusMarkdownCore.xcframework.zip", checksum: "05906668f87e116314dbac55dc7fdc0fab8080b70d8f690b52e053042b788fbb"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.11/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "1b2b78eda0697506b80ebd73b5ce5a4eb2ab96ef7df8fec00e539a5ea38430ab"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.11/SiriusMarkdownMathEngine.xcframework.zip", checksum: "f76da7860c0bcaea9d63853c107e0a3bffbcde52ed454e94d80d32e45e4a1751"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.11/SiriusMarkdownMath.xcframework.zip", checksum: "c53c489240818a7f539f15e79338d18db46304f37595ed1381e5d452af528cba"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.11/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "38b31aad6696f65c274d8b21163069d56561597793b2557889fa938305873bc7"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.11/SiriusMarkdownQuickLook.xcframework.zip", checksum: "812c9815573f60af15302546d49bdf08485d9040ec4c969ca488096ae51362c0"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.11/SiriusMarkdownSupport.xcframework.zip", checksum: "19ff58729da09221814a8686a8cea0e2d3d2e9d7fc4599dfe0bf53101e924d05")
    ]
)
