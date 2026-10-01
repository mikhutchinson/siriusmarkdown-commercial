# Compact tables and explicit page columns

Reader layout remains the default. A document can opt into compact table metrics,
explicit page columns, or both. These are reflow controls, not a promise to reproduce
an imported PDF's typography, coordinates, floats or pagination.

## Why an import preview can grow

A 900 by 1200 point page with 40 point margins has an 820 by 1120 point content box.
Readable raster export renders prepared native content at that measure. Its typography
comes from the preparation configuration; `typography: .reader` controls the separate
text-flow exporter and does not change raster font sizes.

The default document theme uses 16 point paragraph metrics, inherited by tables,
12 point horizontal and 9 point vertical cell padding, and at least 38 point rows.
Default preferred column widths have 112 or 132 point floors. Readable export narrows
columns using measured wrapping units. Tables that remain too wide continue in column
groups, repeating the first identifying column. Vertical continuations repeat headers
and retain complete rowspan groups. This intentionally favors readable text over
fitting an arbitrarily wide table onto one sheet.

Ordinary Markdown and sanitized HTML do not describe page columns. Without explicit
layout metadata the engine exports one column. Changing page dimensions or selecting
`.reader` does not recover columns from an imported paper.

## Table metrics

Set metrics before preparing the snapshot. The same theme must accompany that snapshot
when rendering or exporting it:

```swift
var configuration = MarkdownRendererConfiguration.document
configuration.theme.tableMetrics = .compact
configuration.theme.tableMetrics?.horizontalPadding = 5
configuration.theme.tableMetrics?.verticalPadding = 3
configuration.theme.tableMetrics?.columnSizing = .content(minimum: 44, maximum: 240)
let prepared = configuration.prepare(snapshot: semanticSnapshot)
```

`MarkdownTableMetrics.compact` uses 12 point system type, 16 point line height,
6 by 3 point padding and a 22 point minimum row height. Body text is unchanged.
Assign a `MarkdownTextStyle` to `typography` to configure font, measured font size,
line height and CoreText font profiles together. Custom font profiles must correspond
to the requested SwiftUI font. Padding and minimum height cannot truncate a cell:
prepared content height and merged-cell constraints still determine the actual row.
Set `theme.tableMetrics = nil` to restore the existing reader defaults.

Column sizing can use content widths with bounds, or `.fixed([140, 70, 180])` for
preferred widths including padding. Missing fixed entries use compact content sizing.
Invalid nonpositive or nonfinite sizing values fall back to supported defaults.
Interactive tables retain horizontal overflow containment. Readable export may narrow
preferred widths or split the table into continuation groups; fixed widths do not
require clipping or font reduction.

Wrapping `.words` prefers complete measured words when fitting export columns.
`.anywhere` permits narrower columns and uses existing prepared emergency breaks for
long words. Both retain every character and explicit line breaks. Neither is a
truncation mode. Unbreakable content may still need emergency wrapping in a narrow
continuation group. The engine does not reduce table font sizes to make data fit.

Metrics apply to GFM and native sanitized HTML tables, including merged cells. A custom
`MarkdownTableCellStyle` should respect the theme's metrics; arbitrary extra view padding
or minimum heights in a custom style cannot be anticipated by the table paginator.

## Page layout API

Explicit layout is supported by `.rasterizedPages` with `.readable` pagination on the
native AppKit and UIKit export paths. It does not change the interactive scrolling
reader or the selectable-text `.textFlow` exporter. Unsupported mode combinations
throw `MarkdownDocumentPrintError.invalidPageLayout` instead of ignoring metadata.

```swift
var layout = MarkdownDocumentPageLayout(columnCount: 2, columnGap: 28)
layout.blocks[titleBlockID] = .init(spansColumns: true)
layout.blocks[wideTableBlockID] = .init(spansColumns: true)
layout.blocks[appendixBlockID] = .init(breakBefore: .page)

let options = MarkdownDocumentPrintOptions(
    pageSize: CGSize(width: 900, height: 1200),
    margins: .init(top: 40, bottom: 40, leading: 40, trailing: 40),
    rendering: .rasterizedPages(scale: 2),
    typography: .reader,
    rasterPagination: .readable,
    pageLayout: layout
)
let document = try await MarkdownDocumentPrintExporter.prepareAsync(
    prepared, configuration: configuration, options: options
)
```

The document fills columns top-to-bottom, then left-to-right. Column count is 1 through
8, the gutter is nonnegative, and every column must have at least 72 points of available
width. Unspecified blocks occupy one column. Tables use that column's measure; wide
tables continue through subsequent columns/pages with their identifying column and
headers. Pictures and equations fit proportionally within their assigned frame; native
XY charts reflow at that width. Vector diagrams retain their prepared intrinsic size
when smaller than the frame. They may reduce to `minimumDiagramScale` (default 0.65),
but a smaller fit throws `diagramRequiresLargerFrame(blockID:)`. The host must explicitly
choose a wider span, a larger page or a different authored diagram layout. The engine
does not silently promote a block to a span. This scale bound limits reduction; it is
not an OCR-based guarantee of minimum label size. Custom diagrams still need visual
review. Setting the scale floor to zero explicitly permits unrestricted reduction.

A spanning block closes the current column band at its deepest occupied point and
uses the full content width. Subsequent ordinary blocks begin a fresh column band below
it. Consecutive spans remain full width. There is no balancing, float reordering or
backfilling of unused earlier columns. Large tables or indivisible row groups may move
to the next page if the residual band is too short. A row group taller than a full page
fails with `contentDoesNotFit`; it is not clipped or reduced to unreadable text.

`breakBefore: .column` advances within the current column band; after the final column
it starts a page. In a spanning section it starts a page. Breaks at an empty frame do
not create blank pages. `.page` always advances to a fresh page when content exists.
Headings use measured lookahead to stay with a following block when the combination
fits and no explicit layout transition intervenes. Longer following prose can start
with its first complete native lines. Compact tables avoid a single final row group
when moving one complete group from the preceding continuation fits both frames.
This is not a general widow/orphan or column-balancing system.

Rules address top-level blocks from the exact semantic snapshot. Nested tables and
figures follow their enclosing block's placement. Split independently positioned HTML
into separate top-level semantic blocks. Unknown or blank block IDs, or rules addressing
paragraphs already consumed by an image/text flow group, fail validation. Apply a rule
to the image-flow owner instead; the group stays together as one layout input.

## Importer sidecar contract

`MarkdownDocumentLayoutManifest` accepts Codable versions 1 and 2. Its `blocks` array
contains only explicit exceptions to ordinary column flow. Each entry supplies:

- `startByte` and `endByte`: exact half-open UTF-8 range of a top-level block in the
  emitted Markdown, including the range boundaries reported by `MarkdownSnapshot`.
- `spansColumns`: Boolean.
- `breakBefore`: `"none"`, `"column"` or `"page"`.

The root supplies `version`, `columnCount`, `columnGap`, and `blocks`. Decode it with
`JSONDecoder`, then call `manifest.resolve(in: semanticSnapshot)` to obtain the page
layout. Resolution rejects unsupported versions, invalid ranges and duplicate entries.
Offsets refer to emitted Markdown, never to PDF byte offsets, Unicode character counts
or source-page coordinates. A transport must bind the sidecar to the exact source bytes,
for example by a SHA-256 digest in the surrounding import result. Range validation alone
cannot detect a same-length source replacement.

Version 2 additionally accepts an optional `regions` array. A region contains
`startByte`, `endByte` and `columnCount`. Its range must begin exactly at a
nonblank top-level block and end exactly at that block or a later top-level block.
Regions must be ordered, nonoverlapping, and use 1 through 8 columns. Every
intervening semantic block belongs to that region. Unassigned blocks use the root
column count. Version 1 rejects nonempty regions and retains its existing behavior.

For a mixed document, use a root `columnCount` of 1 and emit regions only where
the importer supports column flow. A reader-only page or section then remains
full width without disabling columns elsewhere. Adjacent regions are independent,
even when their column counts match: the previous band closes at its deepest
occupied point. Column breaks apply within the active region. Spanning rules
still use the full content width. There is no implicit balancing or reordering.

The equivalent native API is `MarkdownDocumentPageLayout.regions`, whose entries
supply contiguous top-level `blockIDs` and a `columnCount`. As with block rules,
image-flow consumed paragraphs cannot be independently addressed. Regions cannot
skip intervening blocks or cross through consumed children; assign the flow owner.

Emit a sidecar only when the importer has evidence for reading order and placement.
If a region is uncertain, omit its regional rule and keep reader layout available.
Do not manufacture columns from table width, titles or document identity. This contract does not imply
that any importer already emits metadata. Relative figure assets retain the existing
host-provided document-relative resolver and resource policies.

## Limits

The resulting PDF consists of raster pages and reports `.pagesAreRasterImages`.
It does not provide selectable PDF text, tagged reading order or vector figures.
Explicit layout uses prepared native blocks and preserves source order; it does not
recover arbitrary PDF geometry, infer multi-column structure, balance columns, position
floating footnotes, or preserve the original paper's page count. Typography remains a
host choice. Evaluate readability at the intended printed size as well as on screen.
