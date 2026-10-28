# Native authoring

Connect a host's native text editor and source transactions to prepared Markdown rendering.

## Keep the host in charge of editing

`MarkdownTextInputController` maps mounted native glyph geometry to UTF-8 source-byte
offsets. The host continues to own text storage, input methods, persistence, revision
validation and its native Undo manager. The SDK does not replace the text editor or
mutate its source. Ordinary readers remain read-only unless the host supplies input
or task-activation hooks.

Keep one controller for the document and attach it before preparing the reader:

```swift
import Foundation
import SiriusMarkdown

@MainActor
func makeInputConfiguration(
    snapshot: MarkdownSnapshot,
    placeSelection: @escaping (Range<Int>) -> Bool
) -> (MarkdownRendererConfiguration, MarkdownTextInputController) {
    let input = MarkdownTextInputController()
    input.documentGeneration = snapshot.generation
    input.placeSelection = placeSelection
    var configuration = MarkdownRendererConfiguration()
    configuration.textInputController = input
    return (configuration, input)
}
```

The selection callback must validate the current source revision and translate UTF-8
byte ranges to the host editor's native indexing. Return false if the selection cannot
be applied. `canPlaceSelection` can reject proposals before that callback. Feed native
selection changes back through `updateSelection(_:)`, and update `isFocused` when the
native editor gains or loses focus. `caretScreenRectChanged` reports the painted caret
in native screen coordinates for input-method positioning.

Update `documentGeneration` when replacing the prepared snapshot. Geometry from other
generations cannot drive movement or deletion, including nonempty selected ranges.
Nil accepts all mounted generations; editing hosts should always supply their current
generation. Source ranges supplied by the host must use valid UTF-8 boundaries within
its current source.
`move(_:extending:byWord:toEdge:)` accepts `left`, `right`, `up` and `down` and proposes
a source selection through the callback. An unknown direction returns false.
`deletionRange(backward:)` returns source ranges for visible graphemes, preserving
composed characters and skipping hidden formatting delimiters. The host validates and
applies any deletion as its own native Undo transaction.

Route rendered-mode native events through `performEditingOperation(requiresCurrentGeometry:_:)`
to preserve their order while a changed document is being prepared. Arrow movement,
visible-grapheme deletion, selection replacement and semantic Return commands require
current geometry. Ordinary insertion at an empty native selection can use
`requiresCurrentGeometry: false`; it proceeds immediately unless an earlier event is
waiting. Each closure performs the host's normal native transaction, so input methods,
source storage and Undo remain host-owned. Capture native hosts weakly.

`hasPendingEditingOperations` reports accepted events that have not run. Finish those
events before saving, exporting or changing editor modes. If the host replaces the
document or abandons an input sequence, call `cancelPendingEditingOperations()`.
Geometry from a replacement snapshot becomes current after its matching layout pass;
the previous layout is never relabeled with the new source generation. Caret painting
uses one native surface and does not reflow the document when only the insertion point
moves.

For an empty document or source gaps between semantic blocks, the host can describe
the insertion point with `emptyParagraphOffset`, `emptyParagraphAnchor`,
`emptyParagraphLines`, `emptyQuoteOffset` and `paragraphGapLines`.
`MarkdownTextInputParagraph` reserves the empty insertion row between the supplied
source offsets; the normal document reader handles mounted semantic blocks.
The anchor is the preceding block's source-end offset, or zero at the document start.
Gap-map keys use those same boundaries. Supply positive line counts for reserved gaps.

For persistent authored rows, publish exact insertion positions with
`updateParagraphSourceOffsets(_:emptyLeaves:generation:)` after parsing. The first
map groups strictly increasing UTF-8 offsets by the preceding block's source end;
zero owns leading rows and an empty document. The `emptyLeaves` map uses the AST's
source ranges for empty headings, list items or trailing empty quotation paragraphs. Positions
may include marker whitespace omitted from a semantic range, but must stay within
the host's current source. Derive these positions from the parsed structure and
source line map on the preparation worker.

For example, `First.\n\n` has a paragraph ending at byte 6 and an empty insertion
row at byte 8:

```swift
input.updateParagraphSourceOffsets([6: [8]], generation: snapshot.generation)
```

The document keeps that row mounted with its source owner when the caret moves
away, so Up, Down and horizontal movement can return to it without changing page
layout. Long gaps use one geometry surface with indexed positions. A standalone
`MarkdownTextInputParagraph` can also receive the matching `generation` explicitly.
The earlier offset/count properties remain available for hosts describing only
an active insertion point.

To retain caret positions within an otherwise empty row, prepare its spaces and
tabs with the reader's current font configuration on the preparation worker:

```swift
// In the host's asynchronous preparation flow, outside view evaluation:
let row = await Task.detached {
    configuration.prepareTextInputParagraph(
        whitespace: "  ", atSourceByteOffset: 8
    )
}.value
// Publish alongside the matching snapshot on the main actor.
if let row {
    input.updateParagraphSourceOffsets(
        [6: [10]], paragraphContent: [row], generation: snapshot.generation
    )
}
```

Each prepared row ends at one canonical position in the gap or `emptyLeaves`
map. Its source range excludes newlines and list/quotation markers. The SDK
rejects other text, negative offsets and overflowing ranges. Keep the native
selection at its actual source position within those spaces/tabs; do not snap
it to the row end. Regenerate the row when its source or paragraph font changes.
Painting, pointer placement, horizontal movement, deletion and width changes
reuse its prepared stops without source scanning or font measurement.
The factory measures the configuration's paragraph font. For a row in a heading,
use a configuration copy whose paragraph font size and profiles match that
heading's style before preparing its whitespace.
The preparation cache shares identical whitespace/font measurements across
source offsets, coalesces concurrent requests, and retains at most 256 entries
with a 1 MiB payload budget. `preparationCache.removeAll()` clears these entries.
Publish rows again after layout-configuration changes even if the source
generation is unchanged. A new publication revokes older mounted row geometry.

Native movement and pointer placement retain visual-row affinity at a soft wrap,
where one source byte can identify both the preceding row's end and the next
row's start. Consecutive vertical arrows follow the row actually selected.

Keyboard focus and source-selection changes reveal the insertion point in the
native scroller. An offscreen source owner is mounted before its exact caret is
revealed. Scrolling by hand retains control until the next caret action. Vertical
movement keeps its horizontal column across scrolling and resets that column when
horizontal layout changes, such as a width or font change.

Set `MarkdownRendererConfiguration.taskInputHandler` to receive an AST-backed task
range and requested state. The host checks its revision, edits that range and records
Undo. Nil retains read-only task markers.

## Preserve authored inline styles

`MarkdownInlineRun.textColor` carries an optional opaque sRGB `MarkdownTextColor`.
The HTML adapter recognizes literal `color: #RGB`, `color: #RRGGBB` and
`color: initial` declarations on supported inline elements. `initial` restores the theme's
text color inside an inherited color. Style attributes are limited to 4,096 UTF-8
bytes and the first 64 declarations. Named colors, alpha, CSS functions, resource
URLs, selectors and layout properties are ignored. Links retain native link color.
Prepared native rendering, rich copy and text-flow PDF export preserve text colors.
A fixed authored color may need adjustment for contrast in different appearances.

Each run's `styleSources` contains exact opening and closing source ranges for
supported authored inline styles. These ranges come from Markdown or HTML semantic
nodes. A missing semantic node range supplies no delimiter pair; this includes
multiline strikethrough in the current Markdown parser. An HTML element with an
implied closing tag also supplies no pair.
The SDK also withholds delimiter pairs when a normalized or container-stripped HTML
projection cannot be reconciled with the exact authored source. Rendering retains
the semantic style even when source ownership cannot be established.
Hosts can use the pairs to balance source transactions across hidden delimiters
when handling Return, selection replacement or deletion. Check both ranges against
the current source revision, and use the semantic visible-text ranges to preserve
grapheme deletion. These values describe source ownership; the SDK does not perform
host edits or grant permission to modify unrelated markup.

## Inspect diagram source without importing parser internals

`MarkdownDiagramSourceAnalysis` validates complete Mermaid input through the same
native semantic parser used for rendering. Run it on a preparation worker or in a
source transaction, never in a SwiftUI body or width-change callback.

```swift
let analysis = try MarkdownDiagramSourceAnalysis(
    source: "flowchart LR\nDraft --> Review",
    referenceDate: Date(timeIntervalSince1970: 1_767_225_600)
)
if case .flowchart(let flow) = analysis.content {
    let identifiers = flow.nodes.map(\.id) // ["Draft", "Review"]
    let connections = flow.edges
}
```

All sixteen native families have a `kind`. Read-only `content` projections expose
flow/state graph identities and labels, sequence participants/messages/notes, chart
axes and series, timeline periods/events, mind-map parentage and Gantt tasks/calendars.
Other content cases identify validated syntax without exposing vendor parser models.
These projections are inspection values, not a source serializer: preserve the original
source, apply bounded source edits and validate the complete result before committing.
Comments, styles, identifiers and unrelated syntax can therefore remain untouched.

Analysis accepts at most 128,000 UTF-8 bytes and rejects unsupported or incomplete
completed input with `Failure.invalidDiagram`; it never repairs a streaming frontier.
Oversized input throws `Failure.sourceTooLarge`. Task cancellation propagates as
`CancellationError`. Rendering and progressive diagram APIs keep their existing
separate contracts.

Gantt analysis captures one `referenceDate`. Its calendar's `parse(_:)` and `format(_:)`
reuse the native calendar, and partial-date parsing uses that same captured instant.
Pass an explicit instant when reproducible date interpretation matters.

## Reveal an outline destination

Supply the same `MarkdownDocumentFindController` to the document and call
`reveal(blockID:)` with a block ID from its current prepared snapshot. The SDK's
native document navigation mounts the target and aligns its source-backed geometry to the reading edge,
including when requested before the view appears. Repeating an ID issues a new
command. This leaves Find closed, preserves its query and selection, and does not
build a search index. Unknown block IDs are ignored.
