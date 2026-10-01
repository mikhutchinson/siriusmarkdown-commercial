# Architecture for integrators

SiriusMarkdown separates parsing, preparation and presentation. Your app supplies
Markdown and renderer configuration; SwiftUI receives prepared content that can
be laid out again as the available width changes.

## Choose a product

| Product | Use it for |
| --- | --- |
| `SiriusMarkdown` | The app-facing API, re-exporting Core and SwiftUI. |
| `SiriusMarkdownCore` | Source, parsing, streaming, semantic models, policies and inline layout without the SwiftUI renderer. |
| `SiriusMarkdownSwiftUI` | Document and streaming views, preparation, themes, interactions and exports. |
| `SiriusMarkdownMathEngine` | Prepared native math images and accessible expression structure. |
| `SiriusMarkdownMath` | The `NativeMarkdownMathRenderer` wrapper for hosts that select it explicitly. The SwiftUI presets already typeset math by default. |
| `SiriusMarkdownQuickLook` | A native macOS preview controller to embed in your own Quick Look extension. |
| `SiriusMarkdownPretextSupport` | Layout fixtures and comparisons for integrations that exercise the layout engine directly. |

## From source to view

1. **Parse.** `MarkdownStream` accepts source and produces `MarkdownSnapshot`
   values. Markdown semantics come from `swift-markdown`. Authorized HTML is
   sanitized into native blocks and inline content.
2. **Prepare.** `MarkdownRendererConfiguration` resolves policies, prepares
   inline measurements, highlights code, typesets math and prepares diagrams.
   Run this work outside SwiftUI view evaluation. For streaming, use
   `MarkdownRenderSession`; for edited documents, see
   [document preparation](Document-Preparation.md).
3. **Present.** Pass `MarkdownPreparedSnapshot` to `MarkdownDocumentView` or
   `StreamingMarkdownView`. Width changes reuse prepared measurements. Rendering
   uses native SwiftUI, AppKit and UIKit surfaces, with CoreText measurement;
   it does not embed a web view.

`MarkdownDocumentView` supplies a document scroller. `StreamingMarkdownView`
fits into a host-owned scroll view. Prefer their `preparedSnapshot:`
initializers; deprecated `snapshot:` compatibility initializers omit full
highlighting, math rendering and inline layout preparation.

## Identity and source mapping

`MarkdownBlockID` identifies a block across updates. Use block or prepared-item
IDs for view identity, rather than array offsets or the snapshot's `generation`.
The generation identifies a source revision and helps reject stale results.

`MarkdownSourceRange` maps rendered content to UTF-8 source offsets and lines.
Selection, copy and editing requests use this mapping. Before applying a request,
the host must check that its source revision still matches the displayed snapshot.

Streaming keeps completed regions stable while reparsing the active tail.
`appendHostBoundary(id:)` inserts a position for host-native content between
Markdown regions. See [streaming](streaming.md) for lifecycle and boundary rules.

## Configuration and resource ownership

Keep configurations and their caches alive across related updates. Recreating
them for every view evaluation discards reusable preparation. Theme, font,
policy and resolver changes require preparation with the new configuration.

Default policies allow safe web, email and relative links. Public HTTPS images
load anonymously through the bounded resolver; choose
`LocalOnlyMarkdownImagePolicy` to disable network pictures. Document-relative
images need a host-supplied base directory. Assign
`DefaultMarkdownImageResolver(documentURL:)` as both image policy and resolver
to combine authorized document-relative files with the default HTTPS loader.

Markdown links and sanitized HTML anchors use the same link policies and
decorations. Native fallback symbols are available immediately; public-site
favicon discovery is separately governed by resource policy and can be disabled
or replaced. See [remote images](document-interactions.md#remote-images) for
viewport loading and completion APIs.

Supported HTML becomes native content. Scripts, event handlers, active embeds
and arbitrary CSS do not execute. HTML authorization does not bypass link or
image policy.

## Rendering hooks

Replace `MarkdownCodeHighlighter`, `MarkdownMathRenderer` or
`MarkdownMermaidRenderer` when your app needs another implementation. Their
output is prepared before presentation. Custom implementations should support
reuse and avoid UI work during preparation.

The default math renderer typesets supported LaTeX on macOS, iOS and visionOS;
unsupported expressions retain a text fallback. `PlainMarkdownMathRenderer`
explicitly selects source text. Preserve the embedded frameworks and their resources when
packaging an app, including the math fonts in `SiriusMarkdownSupport.framework`.
See [native mathematics](math.md) for equation syntax, resolution and supported
commands.

The default diagram renderer uses native preparation on macOS, iOS and visionOS.
The
[diagram guide](Native-Mermaid.md) lists supported syntax and export behavior.
Code highlighting has its own bundled runtime and remains independently replaceable.

## Themes and block styles

`MarkdownTheme` controls typography, spacing, colors and preparation metrics.
The `.document` and `.compactChat` configurations provide reading and chat
presets; `.gitHub` supplies a GitHub-inspired appearance.

`MarkdownDocumentStyle` groups block styles. Individual style protocols customize
headings, paragraphs, quotes, code, tables, lists, math, HTML and diagrams around
already-prepared labels. Do not parse or prepare Markdown inside a style's
`makeBody(configuration:)`.

Style precedence, from highest to lowest, is a per-block `.markdown` environment
modifier, an environment document style, the configuration's document style,
then the default style. Changing a visual wrapper does not replace the theme's
typographic metrics.

## Host responsibilities

Your app owns document storage, incoming stream transport, navigation, file access,
editing transactions and Undo. The renderer reports source-backed interaction
requests; it does not mutate the document. See [document interactions](document-interactions.md)
for Find, selection, formatting, image editing, table actions and PDF export.

For large documents, use [preparation windows](Document-Preparation.md#viewport-windows)
and measure the complete integration with the [performance guide](performance.md).
