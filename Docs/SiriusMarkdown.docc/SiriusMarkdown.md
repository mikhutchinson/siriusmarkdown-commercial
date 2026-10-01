# ``SiriusMarkdown``

Native Markdown rendering for SwiftUI, with streaming, prepared layout, math, diagrams and source-backed interaction.

## Overview

Import `SiriusMarkdown` for the app-facing API. The package uses `swift-markdown` for Markdown
semantics, CoreText for text measurement, and native SwiftUI/AppKit/UIKit surfaces for presentation.
It does not embed a web view to render a document.

### Render a document

Create a ``SiriusMarkdownCore/MarkdownStream``, finish it, and prepare its snapshot before passing
it to ``SiriusMarkdownSwiftUI/MarkdownDocumentView``. Keep preparation outside SwiftUI view evaluation;
for substantial documents, run it on a worker and publish the prepared result to the view.

```swift
import SwiftUI
import SiriusMarkdown

var stream = MarkdownStream()
stream.append("# Hello\n\nA document with **Markdown** and $E = mc^2$.")
stream.finish()

let configuration = MarkdownRendererConfiguration.document
let snapshot = stream.snapshot()
let prepared = await Task.detached {
    configuration.prepare(snapshot: snapshot)
}.value

// Present from the main actor.
MarkdownDocumentView(preparedSnapshot: prepared, configuration: configuration)
```

### Stream a reply

Create a ``SiriusMarkdownSwiftUI/MarkdownRenderSession`` on the main actor, keep it alive in your
host, and append incoming text. Observe the session directly so asynchronous preparation updates the view.
Sealed regions retain their identity; the active tail changes as text arrives. Width changes reuse
prepared measurements.

```swift
import SwiftUI
import SiriusMarkdown

struct ReplyView: View {
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

Call `session.append(chunk)` on the main actor and `session.finish()` when the reply ends. Use
`@StateObject` when your view creates and owns the session.

### Math, diagrams and code

The document and chat presets typeset math natively by default. Use the public
`PlainMarkdownMathRenderer` hook when source text is the intended presentation. Invalid or unsupported
input retains a deterministic source fallback.

``SiriusMarkdownSwiftUI/DefaultMarkdownMermaidRenderer`` prepares native diagrams on macOS, iOS and
visionOS. Graph and geometry families produce prepared PDF/SVG/ASCII and accessibility descriptions.
These native diagram paths do not use JavaScriptCore or WebKit. Unsupported syntax keeps its source instead
of drawing a partial diagram. The supported families include flowchart, sequence, class, state, ER,
XY chart, quadrant, pie, journey, timeline, mind map and Gantt.

Code highlighting is a separate preparation step. Its default backend may use JavaScriptCore with
highlight.js; unrecognized languages or an unavailable backend retain plain code. Hosts can replace
the highlighter through ``SiriusMarkdownSwiftUI/MarkdownRendererConfiguration``.

### Interaction and policy

Source-backed document selection is the default on macOS and touch platforms. On macOS it uses a
bounded AppKit event surface; native leaf selection is an explicit compatibility option. The two
selection owners are mutually exclusive. Prepared source mappings also support Find, navigation,
copy-as-Markdown and opt-in formatting commands.

The default inline rendering mode is `coreTextPaintedLines`. `preparedNativeLines` and `systemText`
are explicit alternatives. ``SiriusMarkdownSwiftUI/MarkdownTheme`` supplies typography and metrics;
block style protocols customize chrome around already-prepared content.

Default policies allow safe web, email and relative links, sanitize authorized HTML, and load a
network picture — an absolute HTTPS picture on a public origin, fetched anonymously inside the
bounded loader's limits. ``SiriusMarkdownCore/LocalOnlyMarkdownImagePolicy`` is the opt-out.
Anonymous public-site favicon discovery is separately governed and can be disabled or replaced.
Hosts own navigation, external resource authorization, document storage and edits; the package
supplies general rendering and interaction hooks.

### Export

``SiriusMarkdownSwiftUI/MarkdownDocumentSurface`` adds optional document affordances. Export can
produce source Markdown, text-flow PDF, or rasterized reader pages on supported platforms. Inspect
reported limitations and test the chosen export mode: text-flow output and raster pages have different
text-selection and pagination properties.

## Topics

### Essentials

- ``SiriusMarkdownCore/MarkdownBlock``
- ``SiriusMarkdownCore/MarkdownBlockKind``
- ``SiriusMarkdownCore/MarkdownSnapshot``
- ``SiriusMarkdownCore/MarkdownBlockID``
- ``SiriusMarkdownCore/MarkdownSourceRange``
- ``SiriusMarkdownCore/MarkdownSourceRevealPolicy``
- ``SiriusMarkdownCore/MarkdownStream``
- ``SiriusMarkdownCore/MarkdownHostBoundary``
- ``SiriusMarkdownSwiftUI/MarkdownDocumentView``
- ``SiriusMarkdownSwiftUI/MarkdownDocumentSurface``
- ``SiriusMarkdownSwiftUI/StreamingMarkdownView``
- ``SiriusMarkdownSwiftUI/MarkdownRenderSession``
- ``SiriusMarkdownSwiftUI/MarkdownRendererConfiguration``
- ``SiriusMarkdownSwiftUI/MarkdownPreparedSnapshot``
- ``SiriusMarkdownSwiftUI/MarkdownPreparedBlockContent``
- ``SiriusMarkdownSwiftUI/MarkdownTheme``
- ``SiriusMarkdownSwiftUI/MarkdownMermaidDiagramAffordances``
- ``SiriusMarkdownSwiftUI/MarkdownMermaidDiagramGeometry``
- ``SiriusMarkdownSwiftUI/MarkdownMermaidViewBox``

### Block styles

- ``SiriusMarkdownSwiftUI/MarkdownDocumentStyle``
- ``SiriusMarkdownSwiftUI/MarkdownHeadingBlockStyle``
- ``SiriusMarkdownSwiftUI/MarkdownParagraphBlockStyle``
- ``SiriusMarkdownSwiftUI/MarkdownBlockQuoteStyle``
- ``SiriusMarkdownSwiftUI/MarkdownCodeBlockStyle``
- ``SiriusMarkdownSwiftUI/MarkdownTableBlockStyle``
- ``SiriusMarkdownSwiftUI/MarkdownTableCellStyle``
- ``SiriusMarkdownSwiftUI/MarkdownListItemStyle``
- ``SiriusMarkdownSwiftUI/MarkdownUnorderedListMarkerStyle``
- ``SiriusMarkdownSwiftUI/MarkdownOrderedListMarkerStyle``
- ``SiriusMarkdownSwiftUI/MarkdownTaskListMarkerStyle``
- ``SiriusMarkdownSwiftUI/MarkdownThematicBreakStyle``
- ``SiriusMarkdownSwiftUI/MarkdownMathBlockStyle``
- ``SiriusMarkdownSwiftUI/MarkdownHTMLBlockStyle``
- ``SiriusMarkdownSwiftUI/MarkdownMermaidBlockStyle``
- ``SiriusMarkdownSwiftUI/MarkdownBlockStyleLabel``
- ``SiriusMarkdownSwiftUI/MarkdownGitHubDocumentStyle``

### Layout and measurement

- ``SiriusMarkdownCore/PreparedInlineContent``
- ``SiriusMarkdownCore/InlineLayoutEngine``
- ``SiriusMarkdownCore/TextMeasurer``
- ``SiriusMarkdownCore/CoreTextInlineMeasurer``
- ``SiriusMarkdownPretextSupport/PretextFixture``
- ``SiriusMarkdownPretextSupport/PretextGoldenComparator``

### Policies and safety

- ``SiriusMarkdownCore/MarkdownLinkPolicy``
- ``SiriusMarkdownCore/MarkdownImagePolicy``
- ``SiriusMarkdownCore/MarkdownHTMLPolicy``
- ``SiriusMarkdownCore/MarkdownCodePolicy``
- ``SiriusMarkdownCore/MarkdownMathPolicy``
- ``SiriusMarkdownCore/DefaultMarkdownPolicy``
- ``SiriusMarkdownCore/LocalOnlyMarkdownImagePolicy``
- ``SiriusMarkdownSwiftUI/MarkdownCopyProvider``
- ``SiriusMarkdownSwiftUI/MarkdownDocumentAffordances``
- ``SiriusMarkdownSwiftUI/MarkdownCodeBlockAffordances``
- ``SiriusMarkdownSwiftUI/MarkdownMermaidRenderer``
- ``SiriusMarkdownSwiftUI/DefaultMarkdownMermaidRenderer``
- ``SiriusMarkdownSwiftUI/MarkdownPreparedMermaidDiagram``
- ``SiriusMarkdownSwiftUI/MarkdownAffordanceActionHandler``
- ``SiriusMarkdownSwiftUI/MarkdownSelectionController``
- ``SiriusMarkdownSwiftUI/MarkdownFormattingCommand``
- ``SiriusMarkdownSwiftUI/MarkdownSelectionFormattingConfiguration``
- ``SiriusMarkdownSwiftUI/MarkdownFormattingHandler``
- ``SiriusMarkdownSwiftUI/MarkdownFormattingRequest``
- ``SiriusMarkdownSwiftUI/MarkdownSelectionFormattingBar``
- ``SiriusMarkdownSwiftUI/MarkdownSelectionFormattingBarStyle``
- ``SiriusMarkdownSwiftUI/MarkdownPreparedImage``
- ``SiriusMarkdownSwiftUI/MarkdownPreparedAttachment``
- ``SiriusMarkdownSwiftUI/MarkdownAttachmentPlaceholderStyle``
- ``SiriusMarkdownCore/MarkdownAttachmentID``
- ``SiriusMarkdownCore/MarkdownInlineAttachmentMetrics``
- ``SiriusMarkdownCore/MarkdownAttachmentSizingSource``
