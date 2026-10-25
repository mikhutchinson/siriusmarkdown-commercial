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

Retain the `MarkdownDocumentFindController` when attaching Find to a stream.
With Find closed, navigation retains its forwarding link action and reuses
completed render regions across appends. Fragment links remain available.
Changing the public renderer configuration, including its host link callback,
still invalidates the affected render content.

## Long documents and active tails

On macOS, `MarkdownDocumentView` and read-only `StreamingMarkdownView` mount native
content around the enclosing viewport. Offscreen items keep stable scroll
destinations and measured heights. This bounds mounted row content; it does not
release the prepared snapshot or source held by the host. Explicitly started
video sessions stay mounted until their source is removed or the reader closes.

Streaming host-boundary content stays mounted. SDK code-collapse, diagram and
selection state follow source identity across viewport changes. A custom style
that owns additional offscreen view state can use
`StreamingMarkdownView.offscreenContent(.retained)` to keep every item mounted.
Rendered editing automatically retains complete input geometry. On other
platforms, automatic streaming presentation keeps its existing lifecycle.

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

Native lists reuse completed groups of prepared items and their measured heights
while the active list grows. A changed item, width, theme, resource or live style
still updates the mounted content. Selection and exact source mappings remain
available. This reduces repeated view and text-geometry work; it does not make
parsing an unsealed semantic list constant-time.

Network requests and image decoding have their own bounds. Bounded caches do
not bound the total memory of a document: source, snapshots, visible prepared
content and decoded images can remain retained by the host. Release closed
documents and reset their sessions.

## Diagnose your workload

Browser selection geometry observation is active only while a document range is
selected. Clearing or replacing the document retires its selection placement work.

For streaming diagrams, accepted semantic statements identify reusable vector
artwork independently of source offsets and an unfinished frontier. Native draft
reuse preserves PDF/SVG resources while refreshing source-backed metadata; ASCII
retains its strict export behavior. Completed unsupported input still falls back
to source. A changed label, structure or theme requires preparation again.

Browser hosts should use `MermaidWorkerClient` for interactive diagrams and
`MermaidRenderQueue` when source arrives continuously. The queue completes a
coherent prefix while coalescing pending appends; measure input-to-callback time
to include that wait. The client keeps graph preparation off the UI thread and measures the actual document font in
bounded batches. Measure its queue-inclusive elapsed time and final mounting as
well as ordinary publication application; the latter does not include later
asynchronous diagram work. See the [browser integration guide](web-page-api.md).

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
