# Document interactions

SiriusMarkdown provides source-backed selection, Find, navigation and copy.
Formatting, image editing and table actions are optional: the renderer reports
commands while your app owns source edits, revision checks and Undo.

## Find and fragment navigation

`MarkdownDocumentView` provides native Find controls on macOS: Command-F opens
Find, Command-G and Shift-Command-G move between results, and Escape closes it.
Matching uses prepared visible text across inline formatting. It excludes hidden
HTML and the source of rasterized equations.
Matching is literal and does not cross block or table-cell boundaries. Decoded
semicolon-terminated HTML character references map to their complete authored
source span; ordinary text beside them retains its exact source range. When HTML
normalization cannot be reconciled with those spans, Find conservatively maps the
text to its containing source node, so selection may include neighboring text.

A host can share a Find controller with the renderer:

```swift
@StateObject private var find = MarkdownDocumentFindController()

MarkdownDocumentView(preparedSnapshot: prepared, configuration: configuration)
    .documentFindController(find)
```

For a host-owned scroll view, use the same modifier on `StreamingMarkdownView`:

```swift
ScrollView {
    StreamingMarkdownView(preparedSnapshot: prepared, configuration: configuration)
        .documentFindController(find)
}
```

The modifier uses the host's scroller. To place Find controls above that scroller,
use `MarkdownDocumentFindBar` with the same controller and suppress inline controls:

```swift
VStack(spacing: 0) {
    if find.isPresented {
        MarkdownDocumentFindBar(controller: find)
    }
    ScrollView {
        StreamingMarkdownView(preparedSnapshot: prepared, configuration: configuration)
            .documentFindController(find, showsInlineControls: false)
    }
}
```

With inline controls suppressed, the host owns presenting Find, including
Command-F (`find.isPresented = true`). Indexing is performed on demand. Code and
table results also reveal content within their horizontal scrollers.

Each Find command reveals the source-backed rendered occurrence, including when
Next or Previous wraps back to the only result. Navigation keeps that destination
aligned while lazy blocks settle, the reader resizes, or prepared content updates.
Scrolling or selecting in the document supersedes the pending reveal. A newer
command, closing Find, replacing the document or removing the view cancels obsolete
navigation. A host should give independent documents independent Find controllers.
Find uses source-backed document highlights while presented, including configurations
that enable native leaf selection or ordinarily disable document selection.

Heading links such as `#installation` reveal their matching block. Generated
slugs are lowercase and Unicode-aware, with numeric suffixes for duplicates.
Sanitized HTML IDs are also supported. Explicit IDs take precedence over generated
slugs; the first duplicate wins. Fragment IDs are case-sensitive and percent-decoded.
Empty anchors reveal their owning block without adding visible text.
Fragment commands also supersede earlier navigation, including commands issued
while the shared index is being built. The renderer keeps the native destination
aligned through subsequent layout changes until reader interaction or another
command takes over.

For windowed readers, build `MarkdownDocumentAnchorIndex(snapshot:htmlPolicy:)`
on the preparation worker once per parsed revision. Use the renderer's HTML
policy. Each destination supplies a top-level block ID and source range so the
host can reveal the window, prepare it, then reveal the block. This index does
not require whole-document text measurement or resource loading. The host owns
fragment routing and preserves the fragment when opening another file.

On iPadOS and visionOS, `.onVisibleBlockChange` reports the first block in the
unobscured scroll viewport. It publishes block transitions and clears its value
when the renderer leaves the view hierarchy, which is useful for an outline or
reading-position indicator.

Hosts can also navigate from source lines. `session.blockID(containingSourceLine:)`
returns a stable block ID; `MarkdownSelectionController.selectSourceLine(_:in:)`
selects the corresponding source in a prepared snapshot. Use
`MarkdownSourceRevealPolicy.exactOnly` for strict containment or
`.nearestRenderedBlock` to resolve a blank-line gap to nearby rendered content.
The host owns scrolling when using `StreamingMarkdownView`.

## Selection and clipboard

On touch platforms, hold or double-tap to select a word, then adjust it with the
native handles and edit menu. Emoji and punctuation preserve grapheme boundaries.
On macOS, document selection supports mouse and keyboard navigation, Copy and
Select All. Inline equations are atomic source-backed items.

Document Copy supplies exact Markdown and semantic plain text, with derived HTML
and macOS RTF where available. Decorations are excluded; allowed link destinations
and sanitized HTML semantics are retained. Programmatic callers can use
`MarkdownSelectionController.selectedPasteboardPayload(in:copyProvider:)`.

For separate preparation windows, create
`MarkdownSelectionDocument(snapshot:copyProvider:)` from the complete semantic
snapshot once per revision. Pass it to `MarkdownSelectionController.setDocument(_:)`
and share that controller across the windows. Select All and Copy can then use
the full document without preparing offscreen content. Pass `nil` when releasing
it. A selection extending beyond the supplied prepared window receives complete
plain text and Markdown, but no partial HTML/RTF representation.

Windowed touch readers in one scroll view share selection handles. Dragging near
an edge scrolls within document bounds; it does not eagerly prepare all offscreen
text. The [Quick Look controller](QuickLook.md#rendering-and-interaction) shares
the document selection and rendering APIs.

## Reader formatting

Set `MarkdownRendererConfiguration.selectionFormatting` to a
`MarkdownSelectionFormattingConfiguration` with a `MarkdownFormattingHandler`.
It is `nil` by default. The handler receives a command rather than an automatic edit.

`MarkdownFormattingCommand.standardCommands` includes bold, italic,
strikethrough, inline code, link, bulleted and numbered lists, quote and code
block. Replace the command list or add `.custom(id:title:systemImage:group:)`
commands for your editor.

Each `MarkdownFormattingRequest` includes the source range, visible plain text,
selected Markdown when a copy provider is supplied, `snapshotGeneration`, and
`sourceLength`. Source ranges include relevant Markdown delimiters. Validate the
request against the displayed snapshot's revision and your current source before
applying a transaction through your Undo system.

Formatting is offered for one contiguous selection. Disjoint selections do not
offer formatting commands; Copy and Select All remain available.

`MarkdownSelectionFormattingPresentation.automatic` uses a bar for pointer
selection and a **Format** section in the touch edit menu. `.bar` and `.menu`
select a consistent presentation explicitly. Hosts can reuse
`MarkdownSelectionFormattingBar` independently and customize its appearance with
`theme.selectionFormatting`.

## Responsive XY charts

The default Mermaid renderer presents prepared XY data with Swift Charts on
macOS and iPadOS. Plot width and tick density adapt while title and axis text
retain their point size. Every data value remains available, including its
accessibility label, when there is insufficient space to show every category tick.

Horizontal charts, grouped bars, lines, mixed series and explicit axis ranges
share this presentation. Source, expansion, zoom and vector PDF/SVG export remain
available. Readable raster PDF export captures the chart at page width; standalone
vector exports retain the prepared diagram's canonical dimensions. Custom Mermaid
renderers use their supplied PDF, SVG or ASCII representation.

## Native print and PDF

On macOS, prepare a fixed pagination result outside view evaluation:

```swift
let output = try MarkdownDocumentPrintExporter.prepare(prepared)
try output.writePDF(to: destination)
let operation = try output.makePrintOperation()
// The host presents and runs the print operation.
```

`MarkdownDocumentPrintOptions` supplies page size, margins, title and font size.
Text-flow output preserves selectable ordinary text and table-cell text, with
link annotations. It supports nested tables, merged cells and repeating ordinary
table headers. A spanning header joined to body rows is not repeated independently.

Prepared images and math draw without additional network requests. Unresolved
resources retain their fallback. Inspect `limitations` for oversized row-span
groups, unsupported images, unrendered math and diagrams.

For native raster pages on macOS or iPadOS, supply the renderer configuration and
set `rendering: .rasterizedPages(scale: 2)`. Choose a pagination mode:

- `.continuous`, the default, captures equal-height strips of the reader.
- `.readable` paginates complete lines and blocks, keeps headings with following
  content, fits whole figures, reflows table cells and wraps highlighted code.
  Tables that remain wider than the page continue in column groups at the
  original text size. Each group repeats the first column for row identification;
  vertical continuations repeat the header. Spanning cells retain their full text
  in every intersecting column group, and row spans stay together.

Both modes report `.pagesAreRasterImages`. Their PDFs have fixed resolution and
no selectable text or link annotations. An indivisible table row or row-span
group taller than the printable page produces an error. An opaque custom block that cannot fit or provide safe
line geometry produces an error.

For interactive readable-raster export, use
`try await MarkdownDocumentPrintExporter.prepareAsync(prepared, configuration: configuration, options: options)`.
It yields between native measurements and captures; cancellation takes effect
at a capture or composition boundary. Native capture needs the main actor and
a host window. Other rendering and pagination modes retain synchronous behavior.

Raster capture uses the active window's appearance, including app overrides.
`MarkdownSyntaxHighlightingColor(light:dark:)` supplies custom syntax-color
variants; its RGBA initializer supplies one fixed color.

## Accessibility

Headings expose heading traits. Allowed links have native activation actions;
a wrapped link remains one semantic element. Figures expose the image description,
ordinal and authored caption separately.

Native math exposes expression structure, including fractions, roots, scripts
and matrix cells. Block equations provide a named scrollable viewport. Default
prepared macOS tables expose rows, columns, cells, spans and header relationships.
Custom table styles and UIKit have their own accessibility presentation; verify
navigation with your app's chosen styles and controls.

## Remote images

Public HTTPS images load by default through `DefaultMarkdownImageResolver` and
`DefaultMarkdownPolicy`. Set `LocalOnlyMarkdownImagePolicy` as `imagePolicy` to
opt out. Document-relative files still need a host-owned base directory and
resolver. `RemoteMarkdownPicturePolicy` and `RemoteMarkdownImageResolver` are
available for hosts that select only the remote-image path, and custom hosts can
implement `MarkdownAsyncImageResolver`.

The loader rejects credentials and private-network endpoints and makes anonymous
requests. It bounds redirects, bytes, decoded dimensions and frames, concurrency,
pending requests, time and caches. PNG, JPEG, GIF and WebP are supported subject
to platform decoding and configured limits. Markdown and sanitized HTML images
share this authorization path.

Image completion refreshes affected prepared blocks. Resetting or releasing the
session cancels pending work; stale results cannot update a replacement document.

Call `session.updateImageLoadingViewport(blockIDs:)` to supply visible top-level
block IDs. An empty set pauses loading; `nil` enables all authorized images.
Leaving the viewport cancels pending requests but retains already prepared images.
The host supplies visibility; the package does not automatically track it.

`waitUntilIdle()` waits for preparation. Use `await session.waitUntilImagesIdle()`
when an export also needs pending image loads and their resulting preparation.

## Contextual image editing

Set `MarkdownRendererConfiguration.imageInteraction` to a
`MarkdownImageInteractionConfiguration` with commands and a perform callback.
The callback receives `MarkdownImageInteractionTarget`, containing the source,
description, picture attributes and source range. Commands appear in native
selection, context-menu and accessibility surfaces. Your app supplies any focused
input or file picker needed by a command.

The host validates the target and document revision before editing, owns Undo,
asset replacement and cancellation, then republishes prepared content. The
renderer does not modify source or files. Linked images, inline images, decorative
icons and equations retain their own interaction behavior; hosts should handle
unsupported editing contexts explicitly.

HTML images support native width, alignment and figure editing, but do not form
paragraph-flow groups. Check `MarkdownImageInteractionTarget.supportsTextWrapping`
before offering wrapping commands.

For direct resizing, supply `imageInteraction.beginResize`. It captures the
revision at gesture start and returns a `MarkdownImageResizeSession`. Its
asynchronous commit callback receives a width in points once on release. Reject
stale revisions, return `false` on failure, and present any error in the host.

Images with intrinsic dimensions provide a corner handle. The preview preserves
aspect ratio and stays within the container and sizing policy. Cancelling the
gesture discards the preview. A successful width remains visible while the host
publishes the replacement prepared content; a failed commit discards it.
Omitting `beginResize` keeps command-based editing without a drag handle.

### Native image wrapping

Standalone pictures can request `{wrap=left}` or `{wrap=right}` alongside width,
alignment and caption. Alignment alone remains block placement; `wrap=none` or
an absent wrap attribute uses ordinary layout. Left and right are physical edges,
including in RTL documents.

The figure anchors before following prose. Headings, lists, tables, display
math, images and host boundaries clear it. A group includes at most 16 paragraphs;
further content begins below the figure. Measures narrower than 160 points or
overwide atomic attachments also place prose below it. Readable raster PDF uses
the same flow geometry. Other Markdown readers may display these extension
attributes as an unfamiliar suffix.

Use `imageInteraction.commandsForTarget` to supply contextual action titles.
The host retains source validation, transactions and Undo ownership.

## Contextual table actions

Set `MarkdownRendererConfiguration.tableInteraction` to offer Table commands in
the touch edit menu or macOS formatting bar. Read-only configurations add no controls.

`MarkdownTableInteractionTarget` identifies a top-level, non-spanning semantic
table by source range and content hash, together with the selected source range.
It supplies a column only when the selection lies entirely within one cell.
Cross-table selections receive no table actions. Validate against current source,
apply the edit through your transaction system, and republish prepared content.

For table-specific typography and explicit page columns, see
[compact tables and page layout](publication-layout.md). Reader layout remains available.
