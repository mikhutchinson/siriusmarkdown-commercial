# SiriusMarkdown browser 0.2.2

October 19, 2026

The shared WASM engine adds Sankey, GitGraph, radar and treemap diagrams with the
same semantic grammars, quantitative geometry and source-fallback behavior as
the native renderer. Prepared SVG stays vector through zoom and export.

Sankey uses proportional ribbons and strict quoted CSV. GitGraph tracks branch
heads, merges, tags and cherry-pick references in LR, TB or BT layouts. Radar
charts support keyed or positional curves and an external numeric scale.
Treemaps preserve weighted hierarchies and use full path/value keys for labels
that cannot fit their regions. See the [diagram guide](../Docs/Native-Mermaid.md)
for the supported subset and limits.

Streaming retains exact authored source and parser-owned frontier metadata.
Unsupported completed statements retain source. Shared word wrapping and
compound flowchart direction handling match the native engine; flow labels can
move clear of nodes with dotted leaders that identify their connectors.

Keep consumer JavaScript, workers, fonts and both WASM modules together when
upgrading. The public playground remains a static site using direct browser
requests; external resources require readable CORS responses. The optional Node
resource gateway remains available for self-hosted integrations. Existing
browser clipboard, printing and platform limits still apply. The native Swift
SDK is separately released as 0.7.8.
