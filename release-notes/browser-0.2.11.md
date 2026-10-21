# SiriusMarkdown Browser 0.2.11

October 21, 2026

Pie diagram text exports now support the same multiline labels accepted by the
diagram parser. Escaped newlines, CRLF, blank lines and tab-separated labels no
longer cause an otherwise valid chart to fall back to source. Each slice keeps
its complete label, quantity, percentage and aligned bar.

Text exports normalize line breaks to LF and expand tabs to eight-column stops
before measuring, including wide CJK characters and composed emoji. The source
returned with the export remains exact. SVG output is unchanged. XY text exports
again honor the explicit `showDataLabel: false` option, matching the native SDK
contract.

This is an independent browser release. The native Swift SDK remains 0.7.10.
