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
        .binaryTarget(name: "SiriusMarkdown", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.19/SiriusMarkdown.xcframework.zip", checksum: "fff618284b4b1129e0ddaaebf4e7f20ff8e4c9fb4ac5ec2fed34a4c0e1d0be7c"),
        .binaryTarget(name: "SiriusMarkdownCore", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.19/SiriusMarkdownCore.xcframework.zip", checksum: "816379bd8001093e488637dddddb5192de92b103fbd01a5f59dd3f8b3aba5d67"),
        .binaryTarget(name: "SiriusMarkdownSwiftUI", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.19/SiriusMarkdownSwiftUI.xcframework.zip", checksum: "94cb35f59c1508b0a80d38560337ebac629679f30d46512e94d4ef2ee5005971"),
        .binaryTarget(name: "SiriusMarkdownMathEngine", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.19/SiriusMarkdownMathEngine.xcframework.zip", checksum: "3671e347b3c11a653eee61e74f1fe4609c9ab41aba3e64eb5ba3667a0d8da0d8"),
        .binaryTarget(name: "SiriusMarkdownMath", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.19/SiriusMarkdownMath.xcframework.zip", checksum: "34daa2f867d2d0175779d713d2217950f39e3388cc593b43df5443efa764d070"),
        .binaryTarget(name: "SiriusMarkdownPretextSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.19/SiriusMarkdownPretextSupport.xcframework.zip", checksum: "e8765099b2f8726917c58f165726d5729a42b69ad9d01fce80d8e1fc5c9cda25"),
        .binaryTarget(name: "SiriusMarkdownQuickLook", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.19/SiriusMarkdownQuickLook.xcframework.zip", checksum: "1edae054c09e8b89cf7c9b557cedb357e9a21cb056b79227bdaf4a2f15eaf97d"),
        .binaryTarget(name: "SiriusMarkdownSupport", url: "https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/download/0.7.19/SiriusMarkdownSupport.xcframework.zip", checksum: "5e4ee8930b0e4aa604d50ca83533402f9ae430e4e7eb7a53ac2986a2e99bd77f")
    ]
)
