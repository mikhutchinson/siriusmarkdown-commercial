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

`literalFind(root, query, options)` searches prepared document text and the
shared diagram engine's visible logical labels. Pass its returned matches to
`setFind(matches, currentIndex)` and `revealRange(matches[currentIndex])`.
Diagram matches highlight their painted SVG glyphs and retain the complete
fence as their atomic source range. Search paint is temporary and is excluded
from SVG downloads and readable exports. Listen for the bubbling
`sm-diagram-find-change` event to refresh an active search when an asynchronous
diagram mounts or its responsive SVG changes; the supplied playground shows
this wiring.

After `revealRange` reveals the active result, the mounted document keeps that
same source match visible through prepared relayout and delayed image sizing.
Manual scrolling, touch navigation or text selection stops following. Existing
matches rebind to new text nodes without reparsing source. `clearFind()` and
document teardown release Find's geometry observation.

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

For interactive Mermaid diagrams, import `MermaidWorkerClient` from
`js/mermaid/worker-client.js` and present its results with `mountMermaid`:

```js
const diagrams = new MermaidWorkerClient({
  wasmUrl: new URL("./dist/sirius-mermaid.wasm", location.href),
  fontDirectory: new URL("./assets/fonts/", location.href),
});
await diagrams.ready;
const diagram = await diagrams.render(block, publication, abortSignal);
if (diagram && diagram.status !== "cancelled") mountMermaid(slot, diagram);
```

For date-dependent Gantt diagrams, the client captures `referenceTime` once as
Unix milliseconds. Supply `referenceTime` in the constructor for reproducible
preparation, or override it on a publication. Use an integer instant in years
1 through 9999. Measurement passes, Today markers and partial dates share that
instant. Changing it revokes a queued result from the previous context. The
lower-level `loadMermaid` API accepts the same option and per-request override.

The client owns one module worker and installs its math font. Install the supplied
document and monospace fonts in the page before creating it. Its default
`canvasMeasurer()` uses the painted document's font resolver: system faces on
Apple platforms and the supplied Inter faces elsewhere. A custom `measure`
function must also expose `fontMetrics(size, weight)` returning
`{ ascent, descent }`. Measurements run in small page-side batches; parsing,
graph layout and SVG preparation run in the worker. SharedArrayBuffer and
cross-origin isolation are not required for this diagram path. Provisional
measurement passes are never presented.

Requests for the same block coalesce to the latest revision. A superseded or
aborted request resolves with `status: "cancelled"`. Call `diagrams.reset()`
when replacing the logical document and `diagrams.dispose()` when retiring the
host. Check that a target slot still belongs to the request before mounting an
asynchronous result. Parser-approved unchanged drafts retain their artwork while
their exact source and frontier metadata update. Unsupported completed input
still retains source.

For continuously arriving source, wrap the client in `MermaidRenderQueue` from
that same module. It completes one coherent prefix while retaining only the
newest queued update for each block, so rapid appends do not repeatedly cancel
an expensive preparation before it can be displayed:

```js
const queue = new MermaidRenderQueue(diagrams);
queue.render(block, publication, (diagram, preparedBlock, preparedPublication) => {
  // Resolve the current slot for this block within the same document epoch.
  mountMermaid(currentSlot(preparedBlock.id), diagram);
});
```

The callback receives the source and publication that actually finished. An
append may display an earlier coherent prefix while the latest is prepared;
source replacement or a theme change revokes the running result. Superseded
queued calls resolve as cancelled. Call `queue.reset()` before replacing the
logical document or retiring its host, and keep the slot ownership checks from
the asynchronous integration above. The ordinary client `render()` API retains
its latest-request cancellation behavior.

The worker bounds its measurement table to 16,384 entries and 8 MiB; a workload
that exceeds these limits returns a diagnostic and source fallback. `stats()`
reports pending requests, preparation reuse, queue/measurement-inclusive elapsed
time, and the largest page measurement slice. The playground also reports diagram
mounting time separately from ordinary publication application.

The lower-level `loadMermaid` API remains synchronous after loading, for hosts
that already own a preparation worker or perform noninteractive export. Supply
`canvasMeasurer()` or equivalent width and font metrics, and install the supplied
math font before rendering math labels. Width-only changes reuse prepared output.

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

Markdown and sanitized HTML images, including inline images, can expose
contextual actions and a resize handle through `imageInteraction`. Supply
`commands` as `{ id, title }` entries, or
`commandsForTarget(target)`, and implement `perform(target, commandID)` in the
host. The target includes its UTF-8 `sourceRange`, `source`, `description`,
picture `attributes`, `documentEpoch` and `sourceRevision`. The `html` and
`standalone` flags let the host choose source transactions appropriate to the
image's authored spelling. `supportsTextWrapping` is true for standalone
Markdown images. HTML containers do not form wrap groups, matching the native
renderer. The playground edits HTML width, alignment and alternative text
without changing neighboring tags or unrelated attributes.
Alignment and caption controls apply to standalone pictures; mixed image/text
leaves retain ordinary inline placement.

To enable dragging, supply `beginResize(target)` returning
`{ commit(width) }`, or `null` when the target is not editable. The host captures
the current source revision at gesture start. Previewing does not write source
or parse the document. `commit` may return a Boolean or a promise for one;
return true only when the source edit was accepted. An accepted preview remains
until the prepared image changes. Rejection, Escape and pointer cancellation
discard the preview; an obsolete completion cannot clear a later gesture.
The playground demonstrates attribute edits and resizing with native editor Undo.

For image-aware layout, spread `view.imageLayoutInput()` into each session
`relayout` request. It supplies rendered attachment geometry keyed by semantic
source range and the current block spacing. Schedule another request from the
mount option `onImageLayout` and the image interaction's `onLayout` callback.
The latter runs when a drag preview or cancellation changes the image box.
These requests adjust cached atomic boxes and line ranges without reparsing or
rebuilding prepared text. Apply the response with `view.applyRelayout` as usual.

An explicit `{wrap=left}` or `{wrap=right}` on a standalone Markdown image
places up to sixteen following prose paragraphs beside the figure. Its caption
participates in the exclusion area. Structural boundaries end the group, and
narrow columns place prose below the whole figure. Alignment alone does not
enable wrapping; `{wrap=none}` restores ordinary block layout.

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

Direct browser requests require readable CORS responses. When an origin does
not permit those requests, pictures retain their unavailable state and links
retain their glyph. Browser networking does not expose DNS answers or
intermediate redirects, so direct image and icon fetchers deny redirects.

The consumer bundle includes an optional Node.js 22+ resource host. From the
bundle directory, run:

```sh
node site/js/host/server.mjs --root site --port 8842
```

Open `http://127.0.0.1:8842/playground/`. This host enables the resource gateway
for pictures and link icons, including public HTTPS origins without CORS
headers. `?resources=direct` selects ordinary browser requests. Static hosting
continues to use direct requests unless a gateway is explicitly configured.

For an embedded reader, pass the same adapter to both resource owners:

```js
import { createResourceGatewayFetch } from "./js/render/index.js";
const remoteFetch = createResourceGatewayFetch({ endpoint: "/__sirius_resource" });
// mountMarkdownDocument(container, { ...options, remoteFetch });
// createResourceFetcher({ ...resourceOptions, fetchImpl: remoteFetch });
```

The Node modules export `createResourceGateway` and
`createResourceGatewayHandler` for an existing server. Configure the handler's
`origin` to the page's exact origin and mount it at the adapter's endpoint.
Place it behind the host's normal authentication and traffic controls. The CLI
binds to loopback by default; `--origin https://your-site.example` sets the
expected browser origin when using a reverse proxy. It does not infer trust
from forwarded headers.

The gateway uses anonymous HTTPS GETs, rejects non-public DNS answers, pins the
validated address while retaining TLS hostname verification, and validates
every redirect before connecting. It follows at most four redirects. It
accepts only image, link-icon and icon-discovery HTML profiles, with byte,
metadata, concurrency, queue, deadline, rate and cache bounds. Client cookies,
credentials and headers are never forwarded. Returned HTML is inert discovery
data; it is not displayed or executed. Browser MIME, decoded-image, frame,
dimension and visible-icon checks still apply. A failed gateway request never
falls back to an unchecked direct request.

The host owns document-relative files and video attachments. The playground's
file controls authorize selected local files. Markdown HTML does not authorize
audio, video, scripts, embedded browsing contexts or active forms. Print uses
the browser's print system and the supplied print stylesheet. Browser HTML
clipboard formats, native pasteboard formats and browser PDF pagination have
their respective platform behavior.

The `localImage(source)` mount option can explicitly authorize an individual
document-relative Markdown or policy-authorized HTML image by returning its
resolved image URL. Return null for files the host has not authorized. The hook is not consulted for
absolute URLs, traversal paths or HTML attribute denials. Host-authorized local
pictures retain their authorization across source edits and relayout. Standalone
pictures preserve their decoded aspect ratio within the available width and
configured picture limits.

## Readable table export

`await view.createReadablePrint({ width: 720, height: 960 })` creates an
independent document snapshot for preview and browser printing. Prepared diagrams
retain their own canvas as vector paint, keeping title and legend contrast in
both appearances, including when CSS printing backgrounds is disabled. Dimensions
describe the printable content area in CSS pixels, at 96 pixels per inch;
the defaults fit Letter paper with half-inch margins. Each dimension must be
between 96 and 16384 pixels. Append the returned `root` to the host's preview
or print container, and call `dispose()` after closing it.

Wide tables continue across column groups with the first identifying column
repeated. Every vertical continuation repeats the table header. All column
groups use the same row ranges, and connected row spans stay together.
Spanning cells retain their complete content in each group they intersect.
Cells wrap at the original font size; an oversized word can break when a
single column cannot otherwise fit. A header or complete row group that is
taller than the printable area rejects the export with a `RangeError`.

The snapshot reuses semantic inline runs, equation vectors and already-loaded
pictures. It does not reparse source, run worker preparation, resolve resources
or change the reader's layout and selection. Intrinsic cell measurement runs
only while creating the export. The returned `tables` array describes each
table's `columnGroups`, `rowRanges` and sheet count. Keep the reader and its
resource owner alive until printing completes.

The playground's **Readable print** action previews these sheets and opens
the browser's Print / Save PDF dialog. Its print container uses normal document
flow, with Letter paper and half-inch margins, then restores the preview when
printing finishes or is cancelled. Custom hosts own paper settings and must
match their print CSS to the chosen content dimensions. This API covers readable
tables; native publication column-region manifests and native PDF exporter
options are separate capabilities.

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
| `relayout` | `documentEpoch`, `sourceRevision`, `layoutRevision`, `width`, optional `blockIds`, and fields from `view.imageLayoutInput()` |
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
