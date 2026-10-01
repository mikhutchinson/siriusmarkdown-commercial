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
publishes prepared snapshots for the view. Call `finish()` when input ends.

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
reused. If several preparation tasks overlap, publish only the result belonging
to the current document revision. `MarkdownRenderSession` manages publication
for its own queued stream operations.

## Incomplete input

The tail can change structure while it is incomplete. An open code fence,
equation, HTML block, table or unresolved reference link may need later input
before it can be sealed. Do not assume that every visible line is already final.

Markdown semantics come from `swift-markdown`. Streaming boundary detection
decides when content can be parsed independently; it does not replace the
semantic parser. Completed tables retain their normal table structure, and
partial cells can appear before the row-ending newline arrives.

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
