# SiriusMarkdown

Native Markdown rendering for SwiftUI on Apple platforms, with streaming,
math, diagrams, highlighted code, tables, images and source-backed interaction.

SiriusMarkdown uses `swift-markdown` for semantics and CoreText for text
measurement. Parse and prepare content outside view evaluation, then pass the
prepared snapshot to a native document or streaming view. Completed streaming
regions are reused while incoming text updates the active tail.

## Installation

Requires Swift 6.3 and macOS 13, iOS/iPadOS 16 or visionOS 1.
Individual features have platform-specific availability.

Add the package in Xcode using its repository URL, or declare a dependency in
`Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/mikhutchinson/siriusmarkdown-commercial.git", from: "0.7.0")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "SiriusMarkdown", package: "siriusmarkdown-commercial")
        ]
    )
]
```

The SDK is distributed as compiled XCFrameworks through Swift Package Manager.
This repository contains the integration material for [0.7.0](release-notes/0.7.0.md).
Public interfaces accompany each platform slice; implementation source is not
part of this distribution. Adding a product also links and embeds its required frameworks and resources.

## Quick start

For a streaming surface, create a `MarkdownRenderSession` on the main actor,
append incoming text, and call `finish()` when the stream ends. Observe the
session directly so asynchronous preparation updates your view:

```swift
import SwiftUI
import SiriusMarkdown

struct TranscriptView: View {
    @ObservedObject var session: MarkdownRenderSession

    var body: some View {
        ScrollView {
            StreamingMarkdownView(
                preparedSnapshot: session.preparedSnapshot,
                configuration: session.configuration
            )
        }
    }
}
```

Keep the session alive in your host and call `session.append(chunk)` as text
arrives. Use `@StateObject` when a view creates and owns its session.

For a static document, prepare before handing data to SwiftUI:

```swift
var stream = MarkdownStream()
stream.append("# Hello\n\nA document with **Markdown** and $E = mc^2$.")
stream.finish()

let configuration = MarkdownRendererConfiguration.document
let snapshot = stream.snapshot()
let prepared = await Task.detached {
    configuration.prepare(snapshot: snapshot)
}.value

// Present on the main actor.
MarkdownDocumentView(
    preparedSnapshot: prepared,
    configuration: configuration
)
```

Keep configurations alive to reuse their caches. For edited or large documents,
see [document preparation](Docs/Document-Preparation.md). Prefer the
`preparedSnapshot:` view initializers; deprecated `snapshot:` initializers omit
full highlighting, math rendering and inline layout preparation.

## Capabilities

- **Structured documents:** headings, paragraphs, quotes, nested and task lists,
  code, tables, links and images. Wide tables and code have contained overflow.
- **Streaming:** append text while completed regions retain stable identity.
  Host boundaries let your app insert native views between Markdown regions.
- **Math:** native LaTeX typesetting on macOS, iOS and visionOS, with inline
  baseline alignment and accessible expression structure. Unsupported formulas
  retain a text fallback. `PlainMarkdownMathRenderer` selects source text.
- **Diagrams and charts:** native Mermaid preparation on macOS, iOS and visionOS,
  with light/dark appearance, selection, zoom, source access and PDF/SVG exports.
  See [supported families and syntax](Docs/Native-Mermaid.md).
- **Code:** language-aware highlighting with a replaceable highlighter. Unknown
  languages and unavailable backends retain plain code.
- **HTML:** supported elements become sanitized native content. Scripts, active
  embeds and arbitrary CSS do not execute.
- **Links and images:** native link symbols and optional public-site icons;
  bounded, anonymous public-HTTPS image loading. Hosts control policies and
  supply access to document-relative files.
- **Interaction:** selection, exact Markdown and rich clipboard copy, Find,
  heading navigation, and optional formatting, image and table commands.
- **Media:** source-backed figures, captions, explicit image wrapping, optional
  host-owned image resizing and editing, and host-resolved prepared video attachments. See [media integration](Docs/media.md).
- **PDF:** macOS text-flow export with selectable text, or macOS/iPadOS raster
  pages matching the chosen reader presentation. Raster pages have fixed
  resolution and no selectable text or link annotations. See
  [print and PDF options](Docs/document-interactions.md#native-print-and-pdf).

Remote images load by default. Assign `LocalOnlyMarkdownImagePolicy` as
`imagePolicy` to opt out. Favicon discovery is independent: disable it with
`linkMetadataResolver: nil`, disable link decorations entirely, or supply a
custom `MarkdownLinkMetadataResolver`.

Resources live inside `SiriusMarkdownSupport.framework` and are included
through the binary package. If you assemble an app manually, embed and sign all
frameworks listed by your chosen product, preserving their resource directories.
See [installation and packaging](Docs/installation.md).

## Customization

`MarkdownTheme` controls typography, colors and spacing. `MarkdownDocumentStyle`
and per-block styles customize presentation around prepared content:

```swift
struct UnderlineH1: MarkdownHeadingBlockStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            configuration.label
            if configuration.headingLevel == 1 {
                Divider()
            }
        }
    }
}

MarkdownDocumentView(preparedSnapshot: prepared, configuration: configuration)
    .markdown.headingStyle(UnderlineH1())
```

Per-block environment overrides take precedence over an environment document
style, then the configuration's document style, then defaults. The `.gitHub`
configuration supplies a GitHub-inspired theme and block style; `.document`
and `.compactChat` provide reading and chat presets. Prepare and present with
the same configuration.

For spreadsheet-style alignment of unmarked table cells:

```swift
var configuration = MarkdownRendererConfiguration.document
configuration.automaticallyAlignsTableValues = true
```

Numbers, currency, percentages and recognized dates/times align right; Boolean
literals center; other values align left. Explicit Markdown alignment wins.
Leading-zero identifiers remain text, and source values are never reformatted.

Formatting and editing commands are opt-in. The renderer reports source ranges
and revisions; your app validates requests and owns edits and Undo. See
[document interactions](Docs/document-interactions.md) for integration details.

## Products and examples

Import `SiriusMarkdown` for the app-facing API. Narrower products are
`SiriusMarkdownCore`, `SiriusMarkdownSwiftUI`, `SiriusMarkdownMath`,
`SiriusMarkdownMathEngine`, `SiriusMarkdownPretextSupport` and `SiriusMarkdownQuickLook`. See the
[product guide](Docs/architecture.md#choose-a-product) for their roles.

Build the bundled macOS examples with:

```sh
Examples/scripts/bundle-macos-demos.sh
```

`MarkdownDemoApp` explores renderer features, `DocumentReaderDemo` presents a
static reader, and `StreamingTranscriptDemo` demonstrates live chat content.

For a macOS preview extension, follow the [Quick Look guide](Docs/QuickLook.md).
It covers the containing app, extension target, signing, provider selection
and local-image access. Adding the package alone does not install an extension.

## Documentation

- [Guide index and API reference](Docs/README.md)
- [Preparing documents](Docs/Document-Preparation.md)
- [Streaming](Docs/streaming.md)
- [Interaction and export](Docs/document-interactions.md)
- [Native mathematics](Docs/math.md)
- [Diagrams](Docs/Native-Mermaid.md)
- [Compact tables and page columns](Docs/publication-layout.md)
- [Installation and packaging](Docs/installation.md)
- [Architecture](Docs/architecture.md) and [performance](Docs/performance.md)
- [Integration checklist](Docs/validation.md)
- [Changelog](changelog.md)

The [API reference](https://siriusmarkdown.com/api/documentation/siriusmarkdown/)
and guides describe the public SDK surface. For support,
[open an issue](https://github.com/mikhutchinson/siriusmarkdown-commercial/issues).

## License

SiriusMarkdown uses [Commercial SDK License 1.0](LICENSE). See the license for
eligibility and terms, or [licensing examples](LICENSING.md) for common uses.
Earlier MIT grants remain intact, including the published 0.6.29 release.

[Third-party notices](NOTICE.md) · [Licensing questions](mailto:licensing@swiftpython.dev)
