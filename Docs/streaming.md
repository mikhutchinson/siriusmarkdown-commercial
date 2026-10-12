# Streaming

`MarkdownStream` accepts append-only Markdown and produces semantic snapshots.
Completed regions are sealed and reused. The remaining mutable tail is reparsed
as more input arrives, allowing incomplete Markdown to develop into its final form.

## Append and finish

```swift
var stream = MarkdownStream()
stream.append("# Hi\n\nStill typing…")
let partial = stream.snapshot()

stream.append(" Done.\n")
stream.finish()
let final = stream.snapshot()
```

`finish()` seals the remaining content and marks the stream finished. Do not
append to that stream afterward; create a new stream for another document.

`sourceLength` reports the UTF-8 byte length. `markdown(in:)` retrieves source
for a `MarkdownSourceRange`, which is useful for exact Markdown copying.
`diagnosticsCounters` exposes parsing and cache activity.

## Present a live stream

Keep a `MarkdownRenderSession` in your main-actor model and send incoming chunks
to `append(_:)`. The session performs parsing and preparation on a worker and
publishes useful prepared prefixes while input continues. It runs one preparation
at a time and combines queued input into the next job. Call `finish()` when input ends.

Observe `session.presentation` when rendering, source access and changes must
refer to the same revision. Its `preparedSnapshot`, `snapshot`, `diff` and
`copyProvider` belong together. Keep a display configuration in the host model
and bind each publication with
`configuration = configuration.bindingSourceAccess(to: presentation)`.
Retain the returned configuration between updates: binding another prefix of
the same document preserves its render revision and sealed view boundaries.
Host theme and policy changes still invalidate normally. The bound provider
retains the exact document and source prefix even after another append or a reset. The individual
snapshot publishers remain available for existing integrations.
The session's own configuration keeps the accepted-source copy behavior used by
existing integrations, so its document copy may include queued source. Use
`presentation.copyProvider` or a configuration bound to that presentation when
copy must match the displayed prefix. During reset, the session configuration
keeps the preceding source owner until the replacement publication arrives.

`documentEpoch` changes on document replacement or reset. `sourceRevision`
identifies admitted source, `resourceRevision` identifies resource updates, and
`revision` orders publications. New appends do not discard a completed useful
prefix. Reset, replacement and cancellation revoke obsolete publication work.
`cancel()` suspends rendering; a later append resumes the accepted source.
Use `documentEpoch` as the document view's `.id` when the same host switches
between documents; it stays constant through appends and finish.
The session's configuration also scopes diagram interaction to that document,
so existing integrations using `preparedSnapshot` and `configuration` clear
diagram camera and selection on reset. For complete-document editing,
`MarkdownDocumentPreparationSession` keeps view identity across preparations;
its explicit `reset()` starts a fresh view identity for both prepared view types.

For integrations that manage their own stream, capture a snapshot and prepare
it outside view evaluation:

```swift
let configuration = MarkdownRendererConfiguration.compactChat
let snapshot = stream.snapshot()
let prepared = await Task.detached {
    configuration.prepare(snapshot: snapshot)
}.value

// Present on the main actor, inside the host's scroll view.
StreamingMarkdownView(preparedSnapshot: prepared, configuration: configuration)
```

Keep the configuration alive across updates so its preparation caches can be
reused. If managing preparation yourself, accept ordered prefixes of the current
document and reject work from replaced documents. Requiring every result to match
the newest append can prevent progress during continuous input.
`MarkdownRenderSession` manages these rules for its queued operations.

## Incomplete input

The tail can change structure while it is incomplete. An open code fence,
equation, HTML block, table or unresolved reference link may need later input
before it can be sealed. Do not assume that every visible line is already final.

Markdown semantics come from `swift-markdown`. Streaming boundary detection
decides when content can be parsed independently; it does not replace the
semantic parser. Completed tables retain their normal table structure, and
partial cells can appear before the row-ending newline arrives.

The default native Mermaid renderer prepares drawable statements inside open
containers, including subgraphs, loops and class bodies. Supported native math
can display children inside open boxes, fractions, roots and matrices before the
closing delimiters arrive. These drafts come from the corresponding semantic
parsers; no closing syntax is added to the source. The public Markdown block
kind remains authoritative: an unfinished display equation may still be a
paragraph or heading carrying `provisionalMath` until its delimiters close.
Parser-owned standalone equations can span temporary AST fragments and blank
lines while retaining one native presentation. A canonical block that also
contains preceding prose remains native text until the equation closes, so its
outside content is preserved. Custom renderers retain their canonical inputs.
`provisionalMath.source` retains authored bytes; `renderSource` and mapped runs
describe the normalized TeX input inside quotes and lists.
A parser-recognized closing delimiter selects strict math admission immediately,
even before the enclosing Markdown tail seals; `hasClosingDelimiter` records that context.

`MarkdownPreparedMermaidDiagram.streamingProgress` describes the consumed source
and unfinished frontier. `MarkdownPreparedBlockContent.mathPreparationOutcome`
describes the current math revision; `mermaidPreparationOutcome` distinguishes
the latest authored admission from a retained diagram. If an appended trailing token has
no new drawable unit, the last native artifact can remain visible; its own source still identifies
what it represents. Copy Source retains the authored input. Finished input uses
strict parsing, and unsupported input keeps its source fallback.
Replacing a block's source with an unrelated revision clears retained artifacts.

Custom renderers retain their existing behavior. Adopt
`MarkdownProgressiveMermaidRenderer` or `MarkdownStreamingMathRenderer` to provide
typed progressive outcomes. Preparation and bitmap decoding occur before view
evaluation; resizing consumes prepared artifacts.
For Mermaid, `.incomplete` permits retention while a still-owned native unit
awaits more input or preparation. `.noDrawableContent` removes a prior artifact
when the current semantic input owns no native unit, such as a reserved
container opener replacing a previously valid bare identifier. An unfinished
node label keeps its earlier node visible until the label becomes drawable.
Uninterpreted trailing tokens are prepared as `streamingFrontier` source text
beside the native artifact, so an incomplete command can visibly advance without
replacing the existing figure. Native equation selection uses
`mathRepresentedSourceRange` and excludes that pending source.

Large unfinished constructs can leave a large tail to parse. See
[performance](performance.md) for profiling streaming workloads and custom highlighters.

## Insert host-native content

`appendHostBoundary(id:)` records a position for a native view between Markdown
regions. It first seals all text received so far, even if that text ends inside
an unfinished construct. Place a host boundary between complete blocks when
you want a code fence, equation or HTML block to remain intact.

`MarkdownSnapshot.items` preserves the order of blocks and host boundaries.
`MarkdownDocumentView` and `StreamingMarkdownView` accept a host-boundary
rendering closure; the default closure renders no content at those positions.
Supply stable `MarkdownHostBoundaryID` values when host insertions have their own identity.

## Snapshot identity

| Property | Meaning |
| --- | --- |
| `blocks` | Semantic blocks, including the current tail. |
| `items` | Blocks interleaved with host boundaries in source order. |
| `generation` | A source revision for detecting stale work. |
| `sourceLength` | The source length in UTF-8 bytes. |
| `isFinished` | Whether `finish()` has been called. |

Use `MarkdownBlockID` and prepared `renderItems` IDs for view identity.
Do not use `generation` as the whole renderer's SwiftUI identity: it changes as
the stream advances and would cause unnecessary remounting.

`MarkdownPreparedSnapshot` contains prepared items and a
`MarkdownPreparedSnapshotDiff`. When preparing with reuse, the diff identifies
new, changed and removed items. `MarkdownRenderSession` publishes both the full
prepared snapshot and its diff, so a host can update associated UI without
rebuilding it from the entire document.

For complete documents edited at arbitrary positions, use
[document preparation](Document-Preparation.md) rather than treating edits as appends.
