# Preparing documents

Prepare semantic snapshots before passing them to a SwiftUI renderer. For a
small static document, `MarkdownRendererConfiguration.prepare(snapshot:)`
prepares the complete snapshot. Run it outside view evaluation, on a worker
for substantial content.

## Reuse across edits

`MarkdownDocumentPreparationSession` reuses matching prepared blocks when an
editor submits a new complete semantic snapshot.

```swift
let preparation = MarkdownDocumentPreparationSession(
    configuration: MarkdownRendererConfiguration(theme: .document)
)

let prepared = try await preparation.prepare(snapshot: snapshot)
// Publish only if this result still belongs to the current document revision.

// Release retained document state when the document closes.
await preparation.reset()
```

One session has one immutable renderer configuration. Create a new session when
the theme, fonts, policy or resolver changes. Unchanged blocks can reuse layout,
highlighting and resources. This API reuses preparation; it does not make
full-source parsing incremental.

The session retains the latest complete prepared snapshot in addition to bounded
configuration caches. Its memory therefore depends on the document's content.

## Viewport windows

For long documents, parse once, split the semantic snapshot into windows, and
prepare windows as they enter the viewport:

```swift
let windows = MarkdownSnapshotWindowSplitter.windows(for: snapshot)
// The default window contains up to 32 top-level blocks.

// For a selected window, run preparation on a worker:
let prepared = try configuration.prepare(window: window) {
    try Task.checkCancellation()
}
```

Render the prepared window with `StreamingMarkdownView`, then release its
prepared state when it is no longer needed. The host owns visibility tracking,
task cancellation and scroll-space reservation.

A `MarkdownSnapshotWindow` never splits a semantic block. Its identity comes
from its first block ID. `estimatedHeight` can reserve offscreen space until
the host replaces it with measured height. Splitting itself does not parse,
measure text or resolve resources.

Windowing reduces eager preparation, but the source and semantic snapshot still
cover the entire document. One large table, list or paragraph can occupy a whole
window. For shared selection and offscreen anchor navigation, see
[document interactions](document-interactions.md).

## Cancellation and publication

For asynchronous images and site icons, initialize `MarkdownRenderSession` with
`snapshot:` and the document's configuration. This uses the streaming renderer's
preparation, resource loading and publication pipeline without reparsing source.
Supply a `copyProvider` for the snapshot's source ranges. For a window, pass its
blocks and source length as a semantic snapshot, and preserve its
`figureOrdinalBase` in the session initializer.

Use `replaceSnapshot(_:)` for later semantic revisions, `waitUntilIdle()` for
preparation, and `waitUntilImagesIdle()` for pending images. A supplied-snapshot
session does not accept streaming appends. Call `cancel()` when a viewport
window disappears to stop pending publication and resource loading. Initialize
a new session if the renderer configuration changes.

Session preparation checks cancellation between top-level blocks, during reuse
indexing, and before committing the completed snapshot. A cancelled result does
not replace the session's last completed snapshot. Reusable cache entries
already produced may remain.

Cancellation does not interrupt a synchronous parse or an individual large
block, highlighter or resource operation. The synchronous
`prepare(snapshot:)` overload prepares the whole snapshot even if its calling
task has been cancelled. Cancel obsolete jobs and check document revisions
before publishing results to the view.
