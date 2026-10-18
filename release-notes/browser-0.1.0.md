# SiriusMarkdown Browser 0.1.0

October 17, 2026

The first browser/WASM MVP runs SiriusMarkdown locally in a module worker.
It includes Markdown and GFM structure, sanitized rich HTML, vector equations,
the documented Mermaid diagram subset, highlighted code, tables, images,
streaming, source-backed selection, rich copy and exact-source Copy Markdown.

The [interactive playground](https://siriusmarkdown.com/playground/) offers
editable examples, streaming with pause and resume, appearance and style
controls, enlarged diagrams, code downloads, browser printing, download progress
and source-preserving recovery after a failed download. Image-only paragraphs
keep complete alternate text, render one proportional picture and reuse that
picture during width changes.

Download the browser ZIP and keep its modules, workers, fonts, licenses and
JavaScript together. The modified ElkSwift corresponding-source archive is
included in the ZIP and supplied separately beside it. Verify the release's
`SHA256SUMS.txt` before deployment. See the
[browser integration guide](https://siriusmarkdown.com/docs/browser/) and
[page API](../Browser/0.1.0/Browser-API.md).

This is a browser MVP, with browser platform limits. Cross-origin images and
icons require CORS permission. Default fetchers deny redirects; document-relative
files need explicit host authorization. Clipboard formats and PDF pagination
follow browser behavior. Standalone Markdown images include contextual editing and host-owned drag resizing
with Undo. Inline/HTML image editing and prepared text-wrapping controls are outside
this release. It does not claim complete native capability parity or
unmeasured performance advantages.

The native Swift SDK remains at 0.7.6. Its products, binary assets and platform
requirements are unchanged by this browser release.
