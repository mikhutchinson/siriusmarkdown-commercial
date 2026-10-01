# Performance

Keep parsing and preparation outside SwiftUI view evaluation. Pass prepared
snapshots to the renderer and reuse them when only the available width changes.
This lets resizing reuse text measurements without reparsing Markdown,
highlighting code or resolving resources again.

## Reuse preparation

Keep a `MarkdownRendererConfiguration` alive for the document or stream. Its
bounded caches reuse prepared text, highlighted code, math and other resources.
Create a new configuration when its theme, policy or resolver requirements change.

For incoming text, keep one `MarkdownRenderSession` and append chunks to it.
Rebuilding a stream from its full source on every update repeats parsing work
that the streaming API can avoid. The session performs parsing and preparation
away from the main actor and publishes prepared results for presentation.

For arbitrary edits to complete documents, use
`MarkdownDocumentPreparationSession`. It reuses matching prepared blocks across
snapshots but does not make full-source parsing incremental. See
[document preparation](Document-Preparation.md) for cancellation and revision handling.

Use stable block and prepared-item IDs in host views. Replacing the whole view's
identity with each snapshot generation remounts content unnecessarily.

## Long documents and active tails

[Preparation windows](Document-Preparation.md#viewport-windows) let a host prepare
visible portions of a document and release them after they leave the viewport.
Source and semantic models still cover the complete document. A single large
table, list, code fence or paragraph remains one semantic block, so a small
window count does not guarantee a small amount of work.

While streaming, completed regions are reused and the active tail is reparsed.
An unfinished construct can keep a substantial tail mutable. Measure long open
fences, tables and reference links as well as ordinary paragraphs. Custom
highlighters may receive the whole active code block on successive updates;
their cost matters even when surrounding blocks are unchanged.

Network requests and image decoding have their own bounds. Bounded caches do
not bound the total memory of a document: source, snapshots, visible prepared
content and decoded images can remain retained by the host. Release closed
documents and reset their sessions.

## Diagnose your workload

Use `MarkdownDiagnosticsRecorder` with the stream and layout APIs. The
`MarkdownStream.diagnosticsCounters` and
`InlineLayoutEngine.diagnosticsCounters` properties expose their counters.

Watch for these patterns:

| Observation | What to inspect |
| --- | --- |
| Historical content is parsed again after every append | Whether the host recreates the stream or replaces its full source. |
| Preparation repeats during ordinary resizing | Whether view evaluation creates a configuration or prepares a snapshot. |
| Cache hits remain low for unchanged content | Configuration lifetime, stable IDs, and changing theme or policy inputs. |
| Long code fences become expensive | Highlighter calls and `codeHighlightByteCount`, not just chunk count. |
| Memory remains high after closing a document | Retained snapshots, tasks, sessions and decoded resources. |

Useful counters include `tailReparseCount`, `prepareCount`, `layoutCount`,
`widthRelayoutCount`, `codeHighlightCount`, `codeHighlightByteCount`,
`mathRenderCount`, and cache hits and misses. Compare counter changes for one
operation rather than treating a cumulative total as a timing measurement.

Profile a release build in your application with representative documents.
Measure parsing, preparation, publication, visible layout and resource loading
separately. Include both cold and warm caches, resizing, rapid updates and
cancellation. Device, font, document structure and custom renderers all affect
results; a single elapsed time cannot identify the bottleneck.

## Using the layout engine directly

`InlineLayoutEngine` separates prepared inline content and measurements from
width-dependent layout. Reuse measured content when calculating multiple
widths, rather than preparing each width independently. CoreText supplies
native glyph measurement on Apple platforms.

Most apps should use renderer preparation instead of managing inline layout
themselves. Direct layout is useful when a host needs text metrics outside the
SwiftUI renderer. See the [architecture guide](architecture.md) for module choices.
