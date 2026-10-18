# Web page API

A browser page hosts the SiriusMarkdown reactor in a module worker. The page sends UTF-8 source and receives JSON publications. This page is the contract for that conversation. Native rendering is a separate API and is not changed by anything here.

## Hosting and integration

Serve the browser bundle over HTTPS, or localhost during development. Keep its
`js`, `assets`, `dist` and `playground` directories together. Serve `.wasm` as
`application/wasm`, JavaScript modules as `text/javascript`, and the supplied
fonts from the same origin. The playground runs its parsing, preparation and
math engine locally in a module worker; it does not require a rendering server.
Its live document and feature gallery both pass authored Markdown through that
engine. The gallery remains editable and can be streamed.

Load `js/theme/theme.css` and import `mountMarkdownDocument` from
`js/render/index.js` to mount a prepared publication. The document handle accepts
`applyPublication` and `applyRelayout`, and exposes `outline`, `setFind`,
`revealRange`, `scrollToFragment` and `destroy`. Keep the worker's source revision
and document epoch with each publication. Starting a different document increments
its epoch. Edits can use `replaceSnapshot` within the same epoch with an increased
source revision. Discard late publications and resource results from older epochs
and superseded revisions. Call `destroy()` when removing a mounted document and release its
worker session when the source is retired.

Apply the matching theme with `applyTheme(root, { preset, appearance })`.
Map its returned `paragraphFontSize` and `paragraphLineHeight` to the session's
`themeMetrics.fontSize` and `themeMetrics.lineHeight`; pass `headings` through
with the matching font traits. The playground also supplies actual font ascent,
descent and family for native-sized line boxes. The presets are `document`,
`compactChat` and `gitHub`. Install the supplied document fonts before measuring
text, and install the supplied math face before enabling prepared math. Width
changes request `relayout` on the prepared session; they do not append or replace
the source. The playground demonstrates the worker, font, Mermaid, resource and
revision wiring together.

Mermaid diagrams use their separate reactor through `loadMermaid` and
`mountMermaid`. Supply `canvasMeasurer()` for preparation with the painted font's
advances and ascent/descent. A custom width-measuring function may expose
`fontMetrics(size, weight)` returning `{ ascent, descent }`, or pass that function
as the separate `fontMetrics` loading option. Install the supplied math font in
the diagram reactor before rendering math labels. The browser uses system faces
on Apple platforms and the supplied Inter faces on other platforms.

Large publications mount in bounded slices. `onRenderComplete({ documentEpoch,
sourceRevision })` reports when the current publication's blocks have mounted;
use it to clear a host loading indicator after checking its epoch and revision.
Subsequent resource completion can update its reserved presentation separately.

An embedding host supplies `onFormat({ command, ranges })`, `onCodeCopy(block)`
and `onCodeExport(block)` to implement its editing, clipboard and file actions.
Formatting controls appear when an `onFormat` handler is supplied. Formatting
ranges use UTF-8 byte offsets into the displayed source. Validate the source
revision before editing and preserve the editor's Undo transaction. The
playground applies those requests to its source editor, downloads code bodies
without their fences, and opens safe links in a separate browsing context.
Without a custom link handler, links use ordinary browser navigation.

Standalone Markdown images can expose contextual actions and a resize handle
through `imageInteraction`. Supply `commands` as `{ id, title }` entries, or
`commandsForTarget(target)`, and implement `perform(target, commandID)` in the
host. The target includes its UTF-8 `sourceRange`, `source`, `description`,
picture `attributes`, `documentEpoch` and `sourceRevision`. Inline images and
HTML images do not expose these editing controls. `supportsTextWrapping` is
currently false for browser image targets.

To enable dragging, supply `beginResize(target)` returning
`{ commit(width) }`, or `null` when the target is not editable. The host captures
the current source revision at gesture start. Previewing does not write source
or parse the document. `commit` may return a Boolean or a promise for one;
return true only when the source edit was accepted. An accepted preview remains
until the prepared image changes. Rejection, Escape and pointer cancellation
discard the preview; an obsolete completion cannot clear a later gesture.
The playground demonstrates attribute edits and resizing with native editor Undo.

## Resource policies and browser limits

The default link-icon resolver returns the prepared glyph immediately and
discovers branded icons asynchronously for public HTTPS origins. Discovery
uses anonymous CORS requests, rejects redirects and private/local URL literals,
bounds HTML and image bytes, validates decoded dimensions and visible pixels,
coalesces origin requests and bounds positive and negative caches. An icon
replaces only its reserved decoration slot. It does not change link identity,
source ranges or wrapping geometry. Pass `linkMetadataResolver: null` to
`mountMarkdownDocument` to disable discovery, or supply an object with
`resolve(destination)` to use a host resolver. The exported
`createLinkIconResolver` supplies the default implementation; its owner calls
`destroy()` to release outstanding requests and cached object URLs.

Cross-origin pictures and icons require readable CORS responses. When an origin
does not permit those requests, pictures retain their unavailable state and
links retain their glyph. Browser networking does not expose DNS answers or
intermediate redirects for the native per-hop checks. The default image and
icon fetchers therefore deny redirects. A host that needs native resource
resolution can provide explicitly authorized bytes through its resource hook.
Do not route arbitrary document URLs through an unrestricted proxy.

The host owns document-relative files and video attachments. The playground's
file controls authorize selected local files. Markdown HTML does not authorize
audio, video, scripts, embedded browsing contexts or active forms. Print uses
the browser's print system and the supplied print stylesheet. Browser HTML
clipboard formats, native pasteboard formats and browser PDF pagination have
their respective platform behavior.

The `localImage(source)` mount option can explicitly authorize an individual
document-relative Markdown image by returning its resolved image URL. Return
null for files the host has not authorized. The hook is not consulted for
absolute URLs, traversal paths or HTML attribute denials. Host-authorized local
pictures retain their authorization across source edits and relayout. Standalone
pictures preserve their decoded aspect ratio within the available width and
configured picture limits.

## Browser selection and copy

Ordinary Copy supplies readable semantic `text/plain` and rich `text/html` from
the displayed publication. Rich paste preserves headings, inline formatting,
safe links, lists and tables. It excludes decoration icons and controls; images
copy their alternate text without loading resources. Equations copy their TeX
text, and code copies its body.

Exact authored source is a separate `text/markdown` representation. The selection
toolbar's **Copy Markdown** action also writes that source as plain text for
editors and native applications. A continuous source copy preserves the blank
lines between blocks. Select All includes the complete published source,
including leading and trailing whitespace. Inline and display equations are
atomic source-backed items: source copying includes the complete Markdown
equation and selection highlights its existing vector bounds.
Mouse drags can start and end within an equation graphic, or extend from the
equation into surrounding prose.

The host supplies source slices from the publication currently displayed, rather
than from a newer editor revision. Partial text selections return authored
Markdown fragments; the renderer does not insert or balance formatting delimiters.
Separately supplied, disjoint copy ranges retain their individual slices.
Destroying a mounted document releases its copy and selection listeners. Source
editors and other editable host fields keep their ordinary clipboard behavior.
Code-body Copy acknowledges success after the host clipboard write completes;
an unavailable or rejected write reports failure.

Browser custom formats do not imply native pasteboard types: a browser may keep
`text/markdown` inside its own custom-data container. Native RTF and the native
Markdown pasteboard identifier are separate platform representations. Web hosts
receive rich content through HTML, and can use **Copy Markdown** when a receiving
application cannot read the custom web format.

## Messages the page sends

| `type` | Fields |
| --- | --- |
| `init` | `wasmUrl`, optional `capabilities`, optional `recover` |
| `append` | `documentEpoch`, `sourceRevision`, `bytes` (UTF-8) |
| `finish` | `documentEpoch`, `sourceRevision` |
| `reset` | `documentEpoch` |
| `replaceSnapshot` | `documentEpoch`, `sourceRevision`, `bytes` |
| `resourceResult` | the fetch result for a `resourceRequests` entry |
| `cancel` | `sourceRevision` |

`init` does not enable recovery. Pass `recover: true` only when this page should replay after a trap. The playground does that when the URL contains `?recover=1`.

## Messages the worker sends

Publications, relayout, copy, outline, and diagnostics keep their existing JSON. A trap adds one event.

### `engine-trap`

The page listens with `window.addEventListener("engine-trap", ...)`. `event.detail` is the worker message:

| Field | Meaning |
| --- | --- |
| `reason` | Engine text such as `unreachable`, `memory access out of bounds`, a stack `RangeError`, or an allocation failure. |
| `op` | The operation that trapped (`append`, `finish`, `resourceResult`, or another session call). |
| `sessionId` | Host-chosen id. The playground uses `playground`. |
| `sourceLength` | Retained UTF-8 length, including the chunk that trapped. |
| `chunkIndex` | Index of that chunk. A later operation reports the last admitted chunk. |
| `lastGoodGeneration` | Generation of the last successful publication, or `0`. |
| `terminal` | The session will not call the engine again. |
| `recovered` | A fresh instance accepted the saved prefix and the trapping call. |
| `attempt` | Recovery attempts used. `0` when recovery is off. |
| `fallbackText` | Retained source as plain text. |
| `documentEpoch` | Epoch of the trapping call. |

The worker posts this message once per incident. The page forwards it as the `engine-trap` event. The status line still updates. The failure is not an unhandled rejection and it does not freeze the page.

## Default policy

Recovery is off. After a trap the worker destroys that session, drops its reference to the Wasm instance so the linear memory can be collected, and posts one terminal `engine-trap`. It does not retry. The page replaces the rendered document with `fallbackText` and ignores later publications for that session.

## Opt-in recovery

With `recover: true` the worker builds a new instance, replays the append-only chunks up to `lastGoodGeneration`, and retries the trapping call. The cap is one attempt (`maxRecoveryAttempts`, default 1). The wait before that attempt is 250 milliseconds times the attempt number (`recoveryBackoffMs`, default 250). If the replay or the retry traps, the incident ends as a terminal `engine-trap` with `fallbackText` still set. A source that traps every time cannot start another attempt.

Block ids and the publication JSON for a document that never traps are the same as a run that recovered onto the same admitted bytes.

## What the host must do

- Handle `engine-trap` on the page.
- On `terminal`, show `fallbackText` as text and stop applying that session's publications.
- Do not write a retry loop. The worker already applied the cap.
- Give each document its own Wasm instance when one hostile document must not take down another. Sessions that share an instance share the trap.
- Leave documents that do not trap on the normal publication path.

A trap is a safety stop for a pathological input. It does not change the JSON of a document the engine accepts.
