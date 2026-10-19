# Native Mermaid diagrams

The default renderer prepares Mermaid diagrams natively on macOS, iOS/iPadOS
and visionOS. Use `MarkdownRendererConfiguration` with its default
`DefaultMarkdownMermaidRenderer`, or supply a custom `MarkdownMermaidRenderer`.
Set `mermaidRenderer: nil` to leave diagram fences as source.

## Viewing and export

Prepared `MarkdownPreparedMermaidDiagram` values contain source, ASCII, light
and dark SVG, geometry, optional PDF variants and an accessibility summary.
The native viewer supports PDF selection, scrolling, zoom and file export.
`MarkdownMermaidDiagramAffordances` controls the viewport and zoom controls;
`MarkdownCodeBlockAffordances` controls copy, export and collapse actions.

Expanded diagrams use the whole canvas, with unfilled controls overlaid at its
edges. The active view and scale mode use text weight rather than a filled
segment or capsule. A soft canvas-edge fade keeps the controls readable when
content pans underneath them. Fit shows the entire figure, including a chart's
title, axes and legend, with clearance for the controls. Initial inline fitting
limits downscaling to keep labels readable. Wider figures pan within the reading
measure and offer Expand; explicit Fit can still shrink the whole figure to the
viewport. Inline figures retain their height limit. Actual Size and the zoom
percentage are relative to the figure at the host's configured text scale.

Zoom preserves the current viewing position. Switching between Diagram and
Source keeps the diagram viewport mounted, and switching appearance preserves
its zoom, pan and PDF text selection. Source opens at the top reading edge.

On UIKit, a long press selects a word and opens the native edit menu. Selection
handles adjust the range. The expanded and inline diagram viewers export files;
the collapsed code-style source action uses the host's code-export handler,
whose default UIKit behavior copies source.

When diagram content changes, selection is preserved when its label can be mapped
unambiguously to the new diagram. Appearance updates retain selection when its
extracted text positions are unchanged. On iOS 17 and later, an already active native
selection display is also preserved when the remapped native text range matches
the new PDF page. Clearing selection or replacing the logical document cancels
that intent.

Preparation occurs before view presentation. Resizing and zoom reuse prepared
resources. Streaming drafts also reuse vector artwork when the semantic parser's
accepted statements and the renderer theme are unchanged. Authored source,
source ranges and frontier coverage still advance independently. ASCII export
retains its separate strict parsing behavior. The draft-artwork cache has both
entry and stored-byte limits.

Streaming native diagrams keep the current prepared vector page
visible through PDFKit page overlays and a current-page presentation during
overlay replacement. PDFKit retains selection and camera interaction.
Diagrams do not require a web view, remote fonts, image downloads or
document-provided scripts. SVG exports have remote font imports removed.
SVG canvas backgrounds use CSS; native image readers can display a transparent
canvas instead. PDF exports paint an explicit background.

## Syntax and limits

Supported families include flowchart, state, sequence, class, entity relationship,
XY chart, quadrant, pie, journey, timeline, mind map and Gantt. Support covers a
subset of Mermaid syntax. Completed unsupported or malformed input retains the source
fence instead of displaying a partial diagram.

While an unsealed fence is streaming, the default renderer can display native
statements inside an open semantic container. `streamingProgress` records how
much authored source has been interpreted and whether a frontier or container
remains open. Source export preserves the complete authored input; PDF and SVG
exports describe the prepared draft. ASCII uses the strict source renderer and
can retain source while a container remains open. Finish uses strict parsing, so an
unfinished or unsupported completed fence returns to its source fallback.
Unfinished labeled subgraph headers stay pending. Open subgraphs and state
groups appear in the native artwork once they own a node. Open sequence frames
appear with their first message or note. Earlier completed nodes and actors
remain visible while each new container's header and first child arrive.
See [Streaming](streaming.md) for custom progressive renderer hooks.

Flowchart and state labels, and sequence participants, messages and notes, support
native LaTeX enclosed in Mermaid's `$$…$$` delimiters. Plain text and formulas can
share a label; `<br/>` separates label lines. For example:

```mermaid
flowchart LR
    A["Curvature $$R^{TM}$$"] -->|$$\frac{\eta(0)+h}{2}$$| B["Boundary correction"]
```

Formulas use the package's native math engine. Label sizing includes the formula's
measured width, ascent and descent. Preparation caches formula glyphs before the
viewer opens; resizing and zooming reuse the finished PDF. SVG exports embed the
prepared formula glyphs and their LaTeX descriptions without external resources.
PDF and SVG formula glyphs and rules use native vector outlines, so zoom and
export do not enlarge a formula bitmap. Ordinary PDF label text remains selectable.
Copy Source retains the original Mermaid and LaTeX.

Text-flow document PDF exports on macOS and iPadOS draw the same prepared vector
diagram page. Complete figures fit the printable measure, captions remain text,
and diagrams inside quotes and lists retain their indentation. An unsupported
or unavailable diagram retains its source and reports `.diagramsAsSourceText`.

Invalid or unclosed math in completed input retains the entire source fence. Math in other diagram
families also retains source. Preparation accepts at most 256 formula spans per
diagram and 32 KiB of source per span. Quoted flowchart labels preserve brackets,
parentheses and semicolons; completed unsupported flowchart statements and unclosed
subgraphs retain source instead of drawing an incomplete graph. State, sequence,
class and ER diagrams also retain source for completed unrecognized statements and unclosed
structures; a successfully prepared diagram does not silently omit those lines.

Sequence `autonumber` accepts a start and increment, including hundredth precision;
`autonumber off` stops numbering. Flowchart feedback edges retain authored arrow
direction and reading order in flat graphs and nested groups that share a flow
direction. Explicit inner direction overrides keep their existing routing
behavior. SVG paint accepts inert named or hex colors and numeric stroke widths,
not resource-bearing paint URLs.

Long geometry-family titles, journey tasks and Gantt labels wrap. XY chart titles
can be quoted or unquoted, such as `title "Monthly revenue"` or `title Revenue`.
XY charts adapt
category ticks to available space while retaining every data value and accessible
label. Automatic bar-chart scales include zero for positive, negative and mixed
values. An explicit `y-axis min --> max` overrides that scale; line-only charts
use a data-fitted automatic scale. Bar values are visible by default in the
native reader and PDF/SVG exports; ASCII output includes their numeric values.
To hide values for a particular chart, precede its header with
`%%{init: {"xyChart": {"showDataLabel": false}}}%%`. Set
`showDataLabelOutsideBar` to `false` to place values inside the bars. Quoted
categories retain spaces, commas and literal punctuation.

Horizontal charts reserve a separate category-label column and place signed
outside value labels at their bar ends. Resizing reuses prepared label measurements.
In the native reader, mixed vertical charts place outside bar values clear of
line marks and neighboring bars where space permits. Displaced values use
dotted leaders to identify their bars; resizing reuses prepared measurements
and series bounds.

Dense entity-relationship diagrams may place labels beside connectors or in a
gutter. Displaced captions use dotted leader lines to identify their relationships;
these leaders remain visually distinct from relationship connectors.

A complex graph can take substantial time to prepare. Cancellation occurs
between phases; it cannot interrupt the synchronous graph-layout call. Native
preparation is serialized, so one expensive graph can delay later work. Cache
entry limits do not impose a total byte budget on arbitrary diagram content.

## Geometry families

The native renderer accepts the following syntax for `quadrantChart`, `pie`,
`journey`, `timeline`, `mindmap` and `gantt`. Unsupported input returns `nil`
from the renderer and leaves the source visible. Headers must stand alone or
be followed by whitespace.

| Family | Accepted | Refused |
| --- | --- | --- |
| `quadrantChart` | `title`; `x-axis low --> high` or `x-axis low`; `y-axis` likewise; `quadrant-1`…`quadrant-4`; `Name: [x, y]` with both in `0...1`. `classDef` lines, `:::class` suffixes, and point-style tails after `]` are ignored. | A coordinate outside `0...1`; an empty body; any other line. |
| `pie` | `pie`, `pie showData`, `pie title X`; `title X`; `"Label" : number` and `Label : number`. Zero and negative values are dropped. `showData` appends `[value]` to legend labels; percentages label slices ≥ 4%. | No positive value; a non-numeric value; any other line. |
| `journey` | `title`; `section Name`; `Task: score`, `Task: score: Actor[, Actor]` with an integer score `1...5`. | A score outside `1...5` or non-integer; a task with no score; any other line. |
| `timeline` | `title`; `section Name`; `Period : Event[ : Event]`; a following `: Event` line joins the period above; a period without `:` has no events. | A body with no period; a continuation with no period above; an empty event. |
| `mindmap` | An indented tree; `text`, `[rectangle]`, `(rounded)`, `((circle))`, optionally with an id prefix (`root((Sirius))`). Children alternate right/left by source order; indentation defines the tree. | `::icon(...)`, `:::class`, backtick Markdown strings, an outdent to or past the root (a second root), an empty tree, mismatched brackets. |
| `gantt` | `title`; `dateFormat` with only `YYYY`, `MM`, `DD` tokens and literal separators; `excludes weekends`; `section Name`; `name :[tags,] [id,] start, end` where tags are `milestone`, `done`, `active`, `crit`; start is a date or `after id [id…]`; end is a date or `Nd`. `axisFormat`, `todayMarker`, `tickInterval`, `weekday`, `inclusiveEndDates`, `topAxis` lines are ignored. | Durations in other units (`1w`, `4h`); an unknown `after` id; other `dateFormat` tokens (`HH`, `mm`, `x`); an end before its start; a first task with no start; no task; any other line. |

Geometry diagrams wider or taller than 11,000 layout points retain their source
instead of producing an oversized PDF. A bare `title` directive sets no title.
A Gantt line with a task separator is treated as a task even if its name begins
with a directive word, such as `Weekday standup :a, …`.

Gantt dates use UTC Gregorian arithmetic. With `excludes weekends`, the end
starts at `start + N days`; each weekend day strictly after the start and up to
the moving end extends it by one day. For example, Saturday `2026-09-26` plus
`2d` ends on `2026-09-29`. A weekend start remains as authored. Dependency
arrows are not drawn.

## Platforms and dependencies

The native path is available on every included platform: macOS, iOS and
visionOS. Code highlighting is separate and uses its own bundled runtime.

The native module includes modified BeautifulMermaidSwift 1.0.4 (MIT) and uses
ElkSwift 1.0.2 (EPL-2.0). See [NOTICE](../NOTICE.md), the
[dependency license](ThirdParty/ElkSwift-EPL-2.0.txt) and
[upstream project](https://github.com/lukilabs/beautiful-mermaid-swift/tree/1.0.4)
for distribution notices and corresponding-source information.
