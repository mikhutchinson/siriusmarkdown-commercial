# SiriusMarkdown Browser 0.2.9

Diagram Find now follows the painted text baseline in Firefox. Matches enclose
the intended glyphs, including wrapped labels, and Next/Previous retain their
source-backed identity. Glyph measurements are reused while their font and
bounds are unchanged. Temporary search paint stays out of SVG and readable
exports.

Diagram fitting now runs after resize-observer delivery, preventing WebKit
resize loops when the reader or expanded viewer changes size. Initial rendering,
explicit Fit, pan, zoom and Source controls retain their existing behavior.

This is a browser presentation update. Both WebAssembly reactors and the shared
Swift parser, prepared geometry, palettes and native SDK 0.7.10 are unchanged.
Update the JavaScript integration modules together with the matching workers,
fonts and reactors from this download. Static hosting, direct resource requests
and browser CORS limits are unchanged.
