# Notices

This SDK distribution uses Commercial SDK License 1.0; see `LICENSE` and
`LICENSING.md`. Earlier MIT-licensed material retains its grant, with the original
notice in `LICENSES/MIT-previous-releases.txt`. The commercial license does not
replace the third-party licenses below or limit their source rights.

The project relies on and credits these third-party projects:

- `swift-markdown` by the Swift project and Apple Inc. provides the runtime Markdown parsing semantics. It is licensed under Apache License 2.0. The included parser is version 0.9.0. Its license and notice are retained at `Docs/ThirdParty/swift-markdown-LICENSE.txt` and `Docs/ThirdParty/swift-markdown-NOTICE.txt`.
- `swift-cmark` 0.9.0 supplies the underlying cmark-gfm parser. Its licenses and notices are retained at `Docs/ThirdParty/swift-cmark-COPYING`.
- `SwiftSoup` by Nabil Chatbi and contributors, derived from Jonathan Hedley's jsoup, provides standards-aware HTML5 tokenization and tree construction for SiriusMarkdown's sanitized native rich-content adapter. It is licensed under the MIT License. The included HTML adapter uses version 2.13.6.
- `highlight.js` provides the embedded common-language grammar bundle used by `DefaultMarkdownCodeHighlighter`. SiriusMarkdown vendors the pinned browser build as a SwiftPM resource and uses it locally through JavaScriptCore. It is licensed under the BSD 3-Clause License; the bundled license lives at `Docs/ThirdParty/HighlightJS-BSD-3-Clause.txt`.
- `BeautifulMermaidSwift` by Craft Docs provides native Mermaid parsing, layout adaptation, and drawing on macOS, iOS, and visionOS. The included native implementation is derived from version 1.0.4 (commit `6a23a29e91af8f5b3e9fc09945332ca193bd69ec`) under MIT. Its license is retained at `Docs/ThirdParty/BeautifulMermaid-Swift-MIT.txt`. Upstream source: https://github.com/lukilabs/beautiful-mermaid-swift/tree/1.0.4.
- `libyaml` 0.2.5 by Kirill Simonov, Ingy döt Net and contributors provides the shared data-only Mermaid configuration parser. Its MIT license is retained at `Docs/ThirdParty/LibYAML-MIT.txt`.
- `ElkSwift` 1.0.2 provides the native ELK graph layout implementation. It is licensed under EPL-2.0, not this project's commercial license. The license is retained in `Docs/ThirdParty/ElkSwift-EPL-2.0.txt`; the corresponding source is available at https://github.com/lukilabs/elk-swift/tree/1.0.2 (commit `32f8042e3509a4819f00ff9cd46e829ec2b26da0`). Distributors must preserve its notices and provide the corresponding source availability required by that license. The SDK and browser use a shared modified fork with portability and deterministic routing changes documented in its `WASI-PATCHES.md`. The exact modified corresponding-source archive accompanies this release under EPL-2.0.
- `beautiful-mermaid` by Craft Docs provides the legacy JavaScriptCore Mermaid preparation fallback on platforms without the native target. The locally bundled runtime is MIT-licensed; its license remains at `Docs/ThirdParty/BeautifulMermaid-JS-MIT.txt`. The default macOS/iPadOS path uses the native implementation above.
- `SwiftMath` by Mike Griebling (a Swift port of `iosMath` by Kostub Deshmukh) supplies native CoreText mathematics on macOS, iOS and visionOS. The document and chat presets use it by default through the public math renderer. SiriusMarkdown includes modified SwiftMath under the MIT License, retained at `Docs/ThirdParty/SwiftMath-MIT.txt`. Its bundled math fonts retain their GUST and SIL Open Font licenses inside the SDK resource bundle.

- `@chenglou/pretext` by Cheng Lou provides the JavaScript text-layout oracle used as the reference for layout fixture comparisons. It is licensed under the MIT License. SiriusMarkdown uses Pretext as a layout reference; the Swift runtime does not vendor or execute Pretext.

## Unicode character data

Text-export display-cell tables are derived from the Unicode Character Database
18.0.0 and its emoji properties, supplied by Unicode, Inc. under Unicode License
V3. The generated tables preserve this notice and the pinned data provenance.
The complete license follows and is also supplied in `Docs/ThirdParty/Unicode-V3.txt`.

UNICODE LICENSE V3

COPYRIGHT AND PERMISSION NOTICE

Copyright © 1991-2026 Unicode, Inc.

NOTICE TO USER: Carefully read the following legal agreement. BY
DOWNLOADING, INSTALLING, COPYING OR OTHERWISE USING DATA FILES, AND/OR
SOFTWARE, YOU UNEQUIVOCALLY ACCEPT, AND AGREE TO BE BOUND BY, ALL OF THE
TERMS AND CONDITIONS OF THIS AGREEMENT. IF YOU DO NOT AGREE, DO NOT
DOWNLOAD, INSTALL, COPY, DISTRIBUTE OR USE THE DATA FILES OR SOFTWARE.

Permission is hereby granted, free of charge, to any person obtaining a
copy of data files and any associated documentation (the "Data Files") or
software and any associated documentation (the "Software") to deal in the
Data Files or Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, and/or sell
copies of the Data Files or Software, and to permit persons to whom the
Data Files or Software are furnished to do so, provided that either (a)
this copyright and permission notice appear with all copies of the Data
Files or Software, or (b) this copyright and permission notice appear in
associated Documentation.

THE DATA FILES AND SOFTWARE ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF
THIRD PARTY RIGHTS.

IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS INCLUDED IN THIS NOTICE
BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES,
OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THE DATA
FILES OR SOFTWARE.

Except as contained in this notice, the name of a copyright holder shall
not be used in advertising or otherwise to promote the sale, use or other
dealings in these Data Files or Software without prior written
authorization of the copyright holder.
