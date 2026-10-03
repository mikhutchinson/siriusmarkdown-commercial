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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.1/SiriusMarkdown.xcframework.zip", checksum: "5ef7a15d6ca144dc2e859f3954ab311efd816e56fc143f71590391dbdd5686cb"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.1/SiriusMarkdownCore.xcframework.zip", checksum: "1530891dc62ed65fcd0a33faab18b849c5a32c67947d6350b9ebf9c8ab32666a"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.1/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "af0dc9789c5ffd8685bcb8d4589c8ae252fe43132eafe2b0c0acfff3c12485b9"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.1/SiriusMarkdownMathEngine.xcframework.zip", checksum: "b4ebe8944375e4ce2df0a9f1bb37f8c5affd1344c47018fdf1e599d571c6844c"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.1/SiriusMarkdownMath.xcframework.zip", checksum: "641e444d900ed50d8c1804ff9789d8db142669c53fe08272bd182b3e2817db19"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.1/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "ab7fed3ed264b5eed8b34dea0a6ff24d2f209158f8df95bdf09b15fedd153b5e"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.1/SiriusMarkdownQuickLook.xcframework.zip", checksum: "c5edb8be4022fc8bf3e70d35aa6277162ed1194f7e5a91e3c0f9271ee34f5533"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.1/SiriusMarkdownSupport.xcframework.zip", checksum: "1ecea4a19bafa905308ea44562dc1c2c850e0d624f5c416b82e49e8c20e18c6e")
    ]
)
