# Notices

This SDK distribution uses Commercial SDK License 1.0; see `LICENSE` and
`LICENSING.md`. Earlier MIT-licensed material retains its grant, with the original
notice in `LICENSES/MIT-previous-releases.txt`. The commercial license does not
replace the third-party licenses below or limit their source rights.

The project relies on and credits these third-party projects:

- `swift-markdown` by the Swift project and Apple Inc. provides the runtime Markdown parsing semantics. It is licensed under Apache License 2.0. The included parser is version 0.7.3.
- `SwiftSoup` by Nabil Chatbi and contributors, derived from Jonathan Hedley's jsoup, provides standards-aware HTML5 tokenization and tree construction for SiriusMarkdown's sanitized native rich-content adapter. It is licensed under the MIT License. The included HTML adapter uses version 2.13.6.
- `highlight.js` provides the embedded common-language grammar bundle used by `DefaultMarkdownCodeHighlighter`. SiriusMarkdown vendors the pinned browser build as a SwiftPM resource and uses it locally through JavaScriptCore. It is licensed under the BSD 3-Clause License; the bundled license lives at `Docs/ThirdParty/HighlightJS-BSD-3-Clause.txt`.
- `BeautifulMermaidSwift` by Craft Docs provides native Mermaid parsing, layout adaptation, and drawing on macOS, iOS, and visionOS. The included native implementation is derived from version 1.0.4 (commit `6a23a29e91af8f5b3e9fc09945332ca193bd69ec`) under MIT. Its license is retained at `Docs/ThirdParty/BeautifulMermaid-Swift-MIT.txt`. Upstream source: https://github.com/lukilabs/beautiful-mermaid-swift/tree/1.0.4.
- `ElkSwift` 1.0.2 provides the native ELK graph layout implementation. It is licensed under EPL-2.0, not this project's commercial license. The license is retained in `Docs/ThirdParty/ElkSwift-EPL-2.0.txt`; the corresponding source is available at https://github.com/lukilabs/elk-swift/tree/1.0.2 (commit `32f8042e3509a4819f00ff9cd46e829ec2b26da0`). Distributors must preserve its notices and provide the corresponding source availability required by that license. The SDK links that source unmodified. A corresponding source archive accompanies this release.
- `beautiful-mermaid` by Craft Docs provides the legacy JavaScriptCore Mermaid preparation fallback on platforms without the native target. The locally bundled runtime is MIT-licensed; its license remains at `Docs/ThirdParty/BeautifulMermaid-JS-MIT.txt`. The default macOS/iPadOS path uses the native implementation above.
- `SwiftMath` by Mike Griebling (a Swift port of `iosMath` by Kostub Deshmukh) supplies native CoreText mathematics on macOS, iOS and visionOS. The document and chat presets use it by default through the public math renderer. SiriusMarkdown includes modified SwiftMath under the MIT License, retained at `Docs/ThirdParty/SwiftMath-MIT.txt`. Its bundled math fonts retain their GUST and SIL Open Font licenses inside the SDK resource bundle.

- `@chenglou/pretext` by Cheng Lou provides the JavaScript text-layout oracle used as the reference for layout fixture comparisons. It is licensed under the MIT License. SiriusMarkdown uses Pretext as a layout reference; the Swift runtime does not vendor or execute Pretext.
