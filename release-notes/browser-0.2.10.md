# SiriusMarkdown Browser 0.2.10

October 21, 2026

Diagram menus can now export Unicode text or ASCII text through the shared
native/WASM parser. All sixteen diagram families have text projections, including
class namespaces, chart values, Gantt dependencies and Git history. Authored
Unicode labels remain intact in both formats; ASCII changes the generated drawing
characters. Text export keeps the diagram's current viewer position and SVG.

The worker API adds `exportText(source, { format, id, streaming, referenceTime },
signal)`. The lower-level renderer accepts `output: "ascii"` or `"unicode"`;
omitting `output` retains the existing SVG response. Successful text responses
report columns and rows in terminal cells. Unsupported or oversized exports retain
the source and a diagnostic. Updating or retiring a diagram cancels its pending
export, including superseded provider failures.

Text layout reserves wide-character columns, keeps reverse-direction labels
readable, and places flow captions clear of arrowheads. Class multiplicities,
ER attribute comments, every XY-series value, exact pie quantities and Gantt
states and dependency identifiers survive the export. Text projections omit color
and font styling; terminal fonts and emoji presentation vary by host.

This is an independent browser release. The native Swift SDK remains 0.7.10.
