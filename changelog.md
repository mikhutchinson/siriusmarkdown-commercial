# Changelog

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

[0.6.29 and earlier source releases](https://github.com/mikhutchinson/SiriusMarkdown/releases)
retain their published source and original license terms.
