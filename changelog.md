# Changelog

## 0.7.14

Fix native paragraphs repeating raw Markdown around inline equations and source line breaks.
Mac and iPad share CoreText text-flow PDF pagination, preserving selectable table cells across pages.

Native input and task activation are available through ordinary public interfaces. Hosts retain
source storage, revision checks, input methods and Undo; stale geometry cannot authorize deletion.
Read-only diagram analysis uses the native semantic parser and SDK-owned inspection values.
Outline controls can reveal block IDs through native navigation without opening Find.

Products and minimum platforms are unchanged; the browser package remains at 0.2.11.

## 0.7.13

macOS prepared native text preserves the final letters of bold paragraphs.
Native text allocation now includes TextKit’s presentation-intent font
substitutions, keeping the painted glyphs inside their text container.

Swift Package products and minimum platforms are unchanged: macOS 13,
iOS/iPadOS 16 and visionOS 1. The separate browser package remains at 0.2.11.

## 0.7.12

macOS document readers remain responsive when selected text stays active during
trackpad momentum scrolling and rapid direction reversals. Native content mounts
around the viewport while offscreen items retain their scroll destinations and
measured heights.

Find and fragment navigation retain their visible destinations during resize.
New scroll or selection commands cancel pending position corrections. Collapsed
code, diagram source and zoom choices, panned diagram regions, and explicitly
started video sessions survive scrolling away from their source.

HTML lists preserve each item's source mapping when multiline content or
character references require fallback ranges, including nested lists and CRLF.

Swift Package products and minimum platforms are unchanged: macOS 13,
iOS/iPadOS 16 and visionOS 1. The separate browser package remains at 0.2.11.

## 0.7.11

Native diagram PDFs retain shaped Unicode, composed and decomposed spellings,
emoji joiners, skin-tone modifiers, variation selectors, flags and keycaps in
selectable text. Text-flow document exports retain these mappings when they
embed prepared diagrams. Glyph paint, color emoji and vector geometry stay the
same, and PDF streams retain lossless compression.

Neutral PDF labels include a leading Unicode direction mark to preserve their
order beside right-to-left labels. That mark can appear in copied text. PDF
readers may also infer different word order or line breaks; Copy Source and SVG
retain the authored text without an added direction mark.

Native diagram text exports also preserve multiline pie labels, explicit XY
data-label suppression and wide Unicode cell alignment.

Swift Package products and minimum platforms are unchanged: macOS 13,
iOS/iPadOS 16 and visionOS 1. The separate browser package remains at 0.2.11.

## Browser 0.2.11 - 2026-10-21

- Preserve multiline pie labels and align their bars and values in text exports.
- Honor explicit XY data-label suppression in text exports.
- Normalize CRLF and tabs before terminal measurement, including wide CJK and
  composed emoji, while retaining the exact source.

[Release notes](release-notes/browser-0.2.11.md).

## Browser 0.2.10 - 2026-10-21

- Export Unicode or ASCII diagram text from the shared parser and preparation
  worker, with revision-safe downloads and explicit source fallback.
- Preserve wide labels, reverse directions, class multiplicities, ER comments,
  every XY-series value, exact pie quantities and Gantt dependency identities.

[Release notes](release-notes/browser-0.2.10.md).

## Browser 0.2.9 - 2026-10-21

- Align diagram Find highlights with painted text baselines in Firefox, including
  wrapped labels. Reuse glyph geometry and refresh it when fonts or bounds change.
- Coalesce diagram fitting after resize-observer delivery, preventing WebKit
  resize loops while preserving explicit Fit, viewer navigation and vector export.

[Release notes](release-notes/browser-0.2.9.md).

## Browser 0.2.8 - 2026-10-21

- Render class namespace hierarchies, display labels and cross-namespace
  relationships through the shared native/WASM layout.
- Share the document palette with native diagrams and retain engine caption,
  header and outline colors through the browser viewer and SVG export.
- Improve default and bundled diagram palette contrast while preserving
  explicit custom colors and translucent artwork.

## 0.7.10 - 2026-10-21

- Render nested and reopened class namespaces, qualified display labels and
  compact namespace projection. Preserve their hierarchy in native vectors,
  accessibility descriptions and native text exports.
- Route class relationships normally into their node boundaries, with visible
  arrowheads and captions clear of connector ink and namespace headers.
- Preserve static and abstract member styles and improve Unicode member sizing
  and native text-export cell alignment.
- Improve default and bundled diagram palettes so labels, connectors and node
  outlines remain readable in light and dark appearances. Preserve explicit
  custom colors and translucent artwork.
- Match native relationship-caption colors to SVG while preserving semantic
  shape outlines, including double circles and subroutine dividers.

## Unreleased

## Browser 0.2.7 - 2026-10-20

- Retain the active Find result through delayed image loading and prepared
  relayout. Rebind highlights after text replacement, preserve the surrounding
  page position, and respect subsequent user scrolling or selection.
- Reuse existing Find highlights for geometry-only updates in large searches.

[Release notes](release-notes/browser-0.2.7.md).

## Browser 0.2.6 - 2026-10-20

- Highlight matching diagram-label glyphs in browser Find, including Safari,
  and reveal individual labels with Next/Previous. Exclude search paint from
  SVG downloads, readable snapshots and printed documents.
- Expand shared diagram syntax, Gantt scheduling, GitGraph topology, quadrant
  styling and XY series/label preparation through the native/WASM engine.
- Add pie donuts, complete positioned legends, truthful precise quantities,
  strict quoted/multiline labels and authored accessibility metadata.
- Preserve exact source, logical-label Find, readable vector paint and exports.
- Keep the prepared diagram canvas with its ink in readable previews and PDFs,
  preserving title and legend contrast in both appearances without resizing.
- Keep cloned SVG markers, clips and gradients independent from hidden reader
  definitions, preserving printed arrowheads and vector geometry.
- Highlight complete Unicode Find matches and reveal the active result inside
  the visible reader; search while typing in the downloadable playground.
- Match native sRGB surface tints and avoid redundant synchronous glyph layout
  while mounting dense SVG figures.

[Release notes](release-notes/browser-0.2.6.md).

## 0.7.9 - 2026-10-20

- Add strict quoted and escaped pie labels, multiline labels, comments and
  authored accessibility metadata through the shared native/browser parser.
  Preserve duplicate rows, exact source, CRLF display breaks and the original
  model initializer; keep entity quotes as data through public SVG exports.
- Keep Journey section/score labels and Timeline period labels readable against
  each prepared palette fill in light and dark appearances.
- Choose contrasting pie percentage ink per sector, including sector opacity,
  while preserving authored text colors.
- Add all five pie legend positions with complete wrapped labels, balanced
  columns, measured centred keys, readable vector text halos and full authored
  stroke clearance. Keep values and percentages with their label words, and
  preserve exact full-circle SVG bounds at fractional centres.
- Add true pie donut contours, authored label positions and typed paint, text
  size, stroke and opacity controls. Keep crowded percentages in complete keys.
- Keep native Mermaid bitmap exports upright and honor transparent themes in
  both source and prepared SVG export.
- Preserve zero pie rows, precise quantities and positive proportions when the
  total overflows. Draw circular sectors and retain source for negative or
  unrepresentable data; avoid false 0%/100% labels on partial shares.
- Preserve authored PDF palette colors and prevent native XY chart replacement
  crashes when category sets, series and axis orientation change.
- Preserve compact flow links and chronological sequence activities; expand
  GitGraph topology/configuration and quadrant styling/layout controls.
- Retain named XY series, point labels, unequal series lengths and precise
  numeric categories. Share line styles, vector symbols and authored palettes
  across native and browser preparation, with complete wrapped legend keys.
- Improve dense chart caption clearance, readable zoom, vector export and
  source-backed diagram search.
- Expand Gantt scheduling with UTC date/time/offset formats, subday and calendar
  durations, forward dependencies, `until`, exclusions/includes, inclusive end
  dates, Today and vertical markers, configured axes and compact full-label rows.
- Share a captured reference instant across native and browser Gantt preparation,
  cache identity and exports. Preserve padded date labels in selectable SVG.
- Resolve unsupported configuration diagnostics in deterministic key order across
  native and WASM processes.

[Release notes](release-notes/0.7.9.md).

## Browser 0.2.2 - 2026-10-19

- Add shared WASM Sankey, GitGraph, radar and treemap parsing, quantitative layout,
  vector SVG, accessibility and progressive source-backed preparation.
- Preserve whole-word label wrapping across native and browser output. Resolve
  compound flow directions by child connections and retain authored feedback
  edges; move obstructed flow labels with identifying dotted leaders.
- Keep positive Sankey and treemap geometry precise through SVG serialization;
  refuse unrepresentable quantities instead of changing their meaning.

[Release notes](release-notes/browser-0.2.2.md).

## 0.7.8 - 2026-10-19

- Add native Sankey, GitGraph, radar and treemap diagrams with selectable vector
  PDF, light/dark SVG, accessibility summaries, strict source fallback and
  parser-owned progressive drafts. Document each supported subset and bounds.
- Preserve proportional ribbons and tiles, full labels and quantitative values;
  use a path/value key when a treemap tile cannot contain its label.
- Respect Mermaid's subgraph direction rule without mutating the parsed model
  or changing authored arrow endpoints. Keep displaced flow labels clear of
  nodes with distinct identifying leaders.
- Share label wrapping and Double preparation geometry with the browser engine.
- Reuse native selection clipping geometry until fragment frames or containing
  viewports change, preserving source mappings as tables grow.

[Release notes](release-notes/0.7.8.md).

## Browser 0.2.1 - 2026-10-18

- Prepare diagrams in a dedicated worker with batched document-font
  measurements, coalesced revisions and cancellation. Reuse unchanged accepted
  statements while keeping authored source and frontier metadata current.
- Keep continuous diagram streams progressing by finishing coherent prefixes;
  revoke obsolete work on source replacement, theme changes or reset.
- Preserve authored reading order in grouped feedback loops that share a
  direction, and keep class-diagram diamonds visible outside endpoint nodes.
- Observe selection geometry only while a range is selected, retiring placement
  work when the document resets or the host is destroyed.

[Release notes](release-notes/browser-0.2.1.md) · [Browser download](https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/tag/browser-0.2.1).

## 0.7.7 - 2026-10-18

- Paint default native inline and display mathematics from prepared glyphs and
  rules at the destination resolution; retain PNG compatibility for custom
  consumers and raster exports.
- Keep initial diagram fitting readable, improve XY label/value clearance and
  entity-relationship caption placement, and accept unquoted XY titles.
- Preserve inline HTML image dimensions and alignment through shared
  normalization, and update semantic parser dependencies to swift-markdown and
  swift-cmark 0.9.0.
- Reuse native streaming diagram vectors when accepted statements and theme are
  unchanged, keeping authored source, source ranges and frontier metadata current.
  Preserve strict ASCII export and completed-input fallback.
- Preserve authored reading order through flat and grouped feedback loops that
  share a direction, including nested groups, while retaining connection
  endpoints, labels and arrowheads.
- Keep class-diagram composition and aggregation diamonds visible outside their
  endpoint nodes in SVG exports.

[Release notes](release-notes/0.7.7.md).

## Browser 0.2.0 - 2026-10-18

- Offer a bounded same-origin resource gateway for public HTTPS pictures and
  link icons without CORS headers, with DNS and redirect validation.
- Export readable browser table snapshots with repeated headers and identifying
  columns while retaining cell text, spans, loaded pictures and equation vectors.
- Preserve document text selection when a browser code action receives keyboard
  focus, including Firefox.

- Edit inline and sanitized HTML images in the browser with source-backed
  resize and Undo. Reserve decoded inline image boxes in prepared line layout,
  and wrap prose around explicit Markdown figures with caption-aware clearing.
- Preserve inline HTML image width and alignment in the shared semantic model.

- The website playground reveals switched examples after prepared layout and
  keeps its readiness indicator in step with source edits and Undo.
- Keep the public playground on static GitHub Pages hosting with direct browser
  resource requests. The optional gateway is supplied for self-hosted consumers;
  cross-origin resources on the public playground still require CORS.

[Release notes](release-notes/browser-0.2.0.md) · [Browser download](https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/tag/browser-0.2.0). The native Swift SDK remains 0.7.6.

## Browser 0.1.4 - 2026-10-18

- Return expanded-viewer focus to its invoker and retain nested reader scroll
  positions through Safari's native modal focus restoration. Reveal Find matches
  within horizontally scrolling content.

## Browser 0.1.3 - 2026-10-17

- Preserve the inline diagram slot and preview scroll position while a viewer is
  open, keep hidden Source views out of sizing, and restore the inline mode on
  dismissal. Keep an expanded viewport in its dialog during reconciliation.

## Browser 0.1.2 - 2026-10-17

- Anchor browser selection and image controls to visible document content, keep
  them inside nested readers, and dismiss or reposition them during focus,
  scrolling and resizing. Keep diagram menus reachable within the reader.
- Preserve selected image actions through accepted attribute edits, acknowledge
  code copying without changing action width, and retain reader scroll positions
  during Find, outline navigation and diagram viewer dismissal.

## Browser 0.1.1 - 2026-10-17

- Retain unchanged browser document subtrees through source edits, updating
  UTF-8 and line bindings for selection, links, copy and image actions. Preserve
  validated image dimensions during replacement and decoded image nodes when
  asynchronous resource metadata arrives.

- Keep browser image-only paragraphs atomic even when their alternate text would
  wrap. Fit validated picture dimensions proportionally and retain the image
  element and prepared state across width changes.
- Preserve explicitly host-authorized local pictures through source edits, and
  display the actual resource-policy denial when no authorization is supplied.

## Browser 0.1.0 - 2026-10-17

The first separate browser/WASM distribution and interactive playground.
The native Swift SDK remains 0.7.6.

- Edit standalone browser image alignment, width and captions through host-owned
  source transactions with Undo. Keep drag previews until the edited picture
  arrives, and preserve authorized local images across later publications.
- Preserve authored placeholder widths and decoded standalone image proportions.
- Let immediate editor Undo supersede an accepted image-resize preview even when
  the intermediate prepared width has not painted.

- Provide an editable browser feature gallery through the real WASM engine,
  source-backed formatting with Undo, safe link activation and code downloads.
- Discover browser link icons anonymously within bounded resource and cache
  limits, retaining prepared glyphs when cross-origin access is unavailable.
- Preserve sealed browser blocks and selection while interleaving streamed
  publications, and reuse live prepared content when long documents resize.
- Preserve standalone display equations after list-owned delimiters and keep
  synthetic empty table-cell source ranges identical across streaming chunks.
- Preserve seeded diagram ordering on wasm32 and measure mixed text/math labels
  with the host's font advances, ascent and descent.
- Print browser documents with readable ink, complete vector diagrams and no
  extra page caused by the editor's viewport height.
- Keep diagram cameras stable during accessibility mouse activation while
  preserving primary-button drag panning.

- Supply semantic plain text and structured rich HTML for browser Copy. Keep
  exact authored source in a separate Markdown format and Copy Markdown action.

- Allow direct browser drags across inline and display equation graphics to select
  their complete source, while keeping provisional source hidden behind vectors.

- Preserve authored block separators and complete-source whitespace in browser
  clipboard Copy. Include atomic display equations when selection starts on them,
  show selection over vector math, and release retired document interaction state.
  Acknowledge code-body Copy after clipboard completion and report rejected writes.

- Keep inline Mermaid labels readable with bounded initial downscaling, panning
  and expansion; preserve explicit Fit for complete overviews. Route nested
  flowchart connectors around title bands while retaining normal node entry.
- Honor document spacing for entity-relationship diagrams without enlarging
  caption gaps twice. Render unquoted XY chart titles and keep horizontal
  category labels separate from signed bar values.
- Keep quadrant point names clear of central grid lines while preserving plotted
  coordinates.
- Reserve space for document Find controls so they do not overlap diagram
  actions. Avoid read-only input-geometry updates during scrolling and resizing.
- Keep mixed-chart bar values clear of line marks and identify displaced values
  with dotted leaders. Fit expanded browser charts within both viewport dimensions
  so titles and legends remain clear of viewer controls in short windows.
- Preserve partial transfer progress when the local Web server encounters bounded
  socket backpressure while serving large Wasm modules.

## 0.7.6 - 2026-10-17

- Keep native paragraph and inline-math geometry stable during speculative
  width measurement, preventing text from wrapping into a rejected narrow
  width and overlapping the following block until another layout or reload.

## 0.7.5 - 2026-10-12

- Typeset native slashed expressions with `\not` and named single/double vertical
  delimiters in prose, tables and exports, preserving authored source and
  streaming prefixes. Support escaped text ampersands and reject unescaped text
  alignment tabs explicitly.
- Typeset native extensible `\xrightarrow` and `\xleftarrow` relations with
  streamed upper and lower labels, retaining native arrowhead geometry in images
  and vector exports.
- Apply authored point-valued row gaps such as `\\[3pt]` per equation row instead
  of displaying the spacing instruction as text. Support multiple column pairs
  in `aligned` while preserving existing two-column spacing.
- Publish useful prepared prefixes during continuous streaming instead of waiting
  for the newest append to become idle. Add coherent presentation revisions and
  source access; preserve accepted source through cancellation and resume.
- Prepare native Mermaid children inside open containers and native math inside
  unfinished boxes, fractions and matrices. Retain strict finished-input parsing
  and existing custom renderer fallbacks.
- Preserve diagram viewport identity across streamed resources and remap PDF
  selection through semantic labels. Keep current prepared vector scenes visible
  through native page overlays during streaming page replacement. Decode prepared
  math pixels before view presentation and bound cached decoded resources.
- Draw closed empty flowchart subgraphs and state composites with their native
  box and title in PDF-backed views and exports.
- Wait for cancelled image loads to exit before declaring image resources idle;
  include retiring loads in the request concurrency limit and reject their late
  results after document or viewport replacement.
- Preserve complete HTML subscript and superscript glyphs in compact paragraphs
  and table cells by preparing enough line height for their combined baseline
  offsets. Ordinary text keeps its existing line height.
- Construct theme presets safely on ordinary worker threads while preserving
  typography and independent value semantics. Retain the released prepared
  artifact initializer signatures.

## 0.7.4 - 2026-10-08

- Preserve recurring prices such as `($2,400/month), ($3,100/month)` as prose
  instead of treating the dollar signs around separate amounts as math delimiters.
  Keep genuine numeric formulas and formulas adjacent to digits supported.

## 0.7.3 - 2026-10-08

- Preserve prepared Mermaid diagrams and formula outlines as vectors in macOS
  text-flow document PDF exports. Share figure sizing, source-range reservation
  and native PDF drawing with the UIKit exporter, including nested diagrams and
  captions. Keep unsupported resources as explicit source fallbacks.
- Mermaid LaTeX glyphs and rules remain vector outlines in PDF and SVG, including enlarged viewing and export.
- Typeset Mermaid flowchart, state and sequence labels with the native math
  engine using `$$…$$`, including measured label sizing and self-contained PDF/SVG
  exports. Preserve source for invalid math and unsupported formula families.
- Preserve punctuation inside quoted flowchart labels and LaTeX commands during
  label normalization. Retain source for unsupported statements and unclosed
  structures in flowchart, state, sequence, class and ER diagrams instead of
  rendering partial diagrams.

- Preserve quoted task states, nesting, formatting and source ranges, including
  empty tasks; align UIKit markers with the painted text baseline.

## 0.7.2 - 2026-10-03

- Expanded diagram and chart viewers use the whole canvas with unfilled controls
  overlaid at its edges. Text weight identifies the active view or scale mode.
- Fit includes the complete figure, titles, axes and legends with room for the
  controls. Inline figures start at the reading edge and remain within scroll bounds.
- PDF zoom commands and percentages consistently use the host's text scale.
  Zoom preserves the panned region; Source and appearance changes retain pan,
  zoom and PDF text selection.
- Find keeps the rendered match visible through lazy layout settlement after
  resizing, including navigation following readable chart export.

## 0.7.1 - 2026-10-02

- Correct Find and fragment navigation in lazy documents using the rendered
  destination's native geometry, including long tables and horizontal code/table
  overflow. Preserve alignment across layout changes without polling or eager
  whole-document rendering.
- Reveal a sole Find match again on Next/Previous; supersede obsolete commands
  after user interaction, dismissal, document replacement and concurrent index
  preparation.
- Keep host-scrolled readers at their proposed width when code has very long
  lines. Preserve exact Find/selection source spans beside HTML character
  references while selecting each decoded reference as one source-backed item.
- Paint source-backed fallback text with its prepared font metrics, keeping
  UIKit code highlights and horizontal reveal aligned with the actual glyphs.
- Retain leaf source geometry for Find when native text selection is enabled,
  including readers that ordinarily disable document selection.
- Preserve source selection and active navigation while resizing an AppKit
  window; its resize border no longer starts a document selection gesture.
- Cancel queued native corrections when the destination view is removed, so
  an obsolete request cannot change the viewport afterward.

## 0.7.0

SiriusMarkdown 0.7.0 brings the engine improvements made since 0.6.29 into a
commercial binary SDK for native SwiftUI applications.

- **Native diagrams and charts:** twelve Mermaid families, light and dark output,
  native XY charts, readable labels, bar values, and PDF/SVG export. Unsupported
  syntax retains its source. Diagram support covers a documented subset.
- **Document preparation:** viewport windows, reuse across edited snapshots,
  supplied-snapshot rendering sessions, cancellation, outlines and semantic anchors.
- **Interaction:** document-wide selection on Mac and touch platforms, Find,
  source-backed copy, and optional formatting, image and table commands.
  Hosts retain revision validation, document edits and Undo.
- **Images and video:** public HTTPS images enabled by default through bounded,
  anonymous loading; native HTML figures, responsive sizing, captions, image
  wrapping and resizing hooks, plus prepared video posters and playback.
- **Mathematics:** native inline, display and table-cell math by default on macOS,
  iOS and visionOS; broader LaTeX notation, semantic accessibility, improved
  raster bounds and resolution, and contained overflow for wide equations.
- **Tables and PDF:** merged-cell geometry, opt-in value alignment and compact
  metrics, readable table continuations, heading and figure grouping, explicit
  page columns and regional layout, and cancellable reader-page export.
  Raster-page PDFs retain their documented text-selection limitations.
- **Quick Look:** a reusable macOS preview controller with shared rendering,
  document-wide Copy, Find and fragment navigation. Consumers supply and install
  their own signed extension.
- **Integration:** preserved prepared rendering and streaming APIs, safe policy
  defaults, public interface files, consumer examples and bundled resources.

## Installation changes

Use `https://github.com/mikhutchinson/siriusmarkdown-commercial.git` and select
0.7.0 or later. Product and import names remain unchanged. The binary SDK requires
Swift 6.3 or later and supports macOS 13, iOS/iPadOS 16 and visionOS 1.
Native mathematics and diagrams are available on macOS, iOS and visionOS.
The 0.7.0 binary distribution does not include tvOS or watchOS slices.

Xcode embeds the required SDK frameworks and their resources automatically.
Manually assembled applications must preserve them; see [installation](Docs/installation.md).

This distribution uses [Commercial SDK License 1.0](LICENSE). Previous MIT
releases and third-party licenses retain their original terms.

## Earlier releases

The 0.6.29 and earlier releases retain their original license terms.
See [licensing](LICENSING.md) for the scope of earlier MIT grants.
