# Changelog

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
