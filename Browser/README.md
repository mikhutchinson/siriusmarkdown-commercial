# SiriusMarkdown for the browser

Browser 0.2.12 is the SiriusMarkdown browser/WASM MVP. It is distributed
separately from the native Swift XCFramework SDK in this repository.
Both reactors include the shared engine from native SDK 0.7.14, including inline
math line-break and HTML list source-mapping fixes. `MANIFEST.json` records
`nativeSDKVersion` and `engineSourceSHA256` so hosts can retain the matching
engine provenance with their complete runtime pin.

- [Download browser 0.2.12](https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/tag/browser-0.2.12)
- [Interactive playground](https://siriusmarkdown.com/playground/)
- [Integration guide](https://siriusmarkdown.com/docs/browser/)
- [Page and worker API](0.2.12/Browser-API.md)
- [Runtime notices](0.2.12/NOTICE.md)
- [Archive checksums](0.2.12/SHA256SUMS.txt)

Extract `SiriusMarkdown-browser-0.2.12.zip` and serve its `site/` directory over
HTTPS, or localhost for development. Keep `js`, `assets`, `dist` and `playground`
together. Serve `.wasm` as `application/wasm`, module JavaScript as
`text/javascript`, and fonts with appropriate font MIME types. Open the included
playground as a complete reference host, or integrate its worker and presentation
modules using the page API above.

The browser uses the actual SiriusMarkdown engine for Markdown/GFM structure,
streamed documents, sanitized rich HTML, native-engine vector equations and the
documented Mermaid subset, including Sankey, GitGraph, radar and treemap. Images,
tables, highlighted code, selection, rich
copy, exact-source Copy Markdown and host-owned formatting use the same authored
source. Unsupported completed diagram syntax retains its source fallback.

The main reactor is about 58 MiB and the separate diagram reactor about 57 MiB
before HTTP compression. Load them when needed and cache a complete version's
matching modules, workers, JavaScript and fonts together. Your marketing or
navigation pages do not need to download the engines.

The browser package supports inline Markdown and HTML image editing, caption-aware
figure wrapping and readable table print snapshots. Contextual controls stay anchored
to visible content, and diagram menus stay inside the reader. Editing retains
unchanged content, including decoded pictures and vector equations and diagrams. Source positions
stay current for selection, copy and image actions.

Expanded viewers preserve the diagram's inline space and restore the reader's
scroll position and previous Diagram or Source mode when dismissed. Safari returns
focus to the invoking Expand button without moving the reader. Find reveals
matches inside horizontally scrolling content.

Diagram menus also export Unicode or ASCII text through the worker. Both preserve
authored labels and numeric data, respecting explicit XY data-label suppression.
Pie labels retain multiline rows, with LF line breaks and tabs expanded to
eight-column stops. Text layouts omit color and typography. The
worker API's `exportText()` accepts the format, source revision context and abort
signal. Downloads are cancelled when their diagram changes. Unsupported or
oversized text exports retain source and report a diagnostic. See the page API
for terminal-cell geometry and limits.

## Browser limits

Current desktop Safari, Chrome and Firefox are the intended browser targets.
JavaScript modules, module workers, WebAssembly and browser font APIs are
required. This MVP does not claim complete native capability parity or an
exhaustive mobile and assistive-input certification.

Documents parse and render locally. External pictures and icons still use
networking. Cross-origin pictures need readable CORS responses; default fetchers
deny redirects and local/private URL literals. Browsers do not expose the native
per-hop DNS checks. A denied picture keeps a placeholder and a denied site icon
keeps its prepared glyph. Document-relative files require explicit host
authorization. Do not introduce an unrestricted proxy for authored URLs.

HTML is sanitized into document content. Scripts, active forms, embedded browsing
contexts and arbitrary CSS are not enabled. Standalone Markdown figures support
alignment, captions, width edits, drag resizing and prepared text wrapping. Inline
Markdown and authorized HTML pictures support width edits; HTML pictures also
support alternative-text editing. The host owns source transactions and Undo.
Narrow columns place prose below wrapped figures.

Browser HTML/custom clipboard formats differ from native pasteboard types.
Use Copy Markdown to transfer exact authored source as plain text. Printing and
PDF pagination use the browser's print system and differ from native PDF export.
Readable print snapshots divide wide tables across column groups and pages,
repeat identifying columns and headings, and retain the original text size. The
live reader remains independent from the print snapshot.

## Optional self-hosted image gateway

The download includes an optional bounded Node resource gateway for public
pictures and icons whose servers do not allow browser CORS requests:

```sh
node site/js/host/server.mjs --root site --port 8843
```

Open `http://127.0.0.1:8843/playground/?resources=gateway`. An existing server can
mount the supplied handler behind its normal authentication and traffic controls.
The browser adapter requires a same-origin endpoint. Public-address checks,
validated redirects, TLS verification and bounded anonymous requests apply to
each fetch. See the page API for the adapter and handler contract.

The public playground stays on static hosting and uses direct browser requests,
with the CORS limits described above. The gateway is optional for self-hosted
integrations and does not require changes to authored Markdown.

## Diagram preparation

Interactive diagrams prepare in a dedicated worker. Continuous
streams finish coherent prefixes while coalescing queued appends, and unchanged
accepted statements reuse preparation. Source replacement, theme changes and
reset revoke obsolete diagram work. See the page API for worker ownership and
timing diagnostics.

## License and corresponding source

Preserve Commercial SDK License 1.0, prior MIT grants, third-party notices and
font/runtime licenses. They are included in the download and retain their own
terms. The download includes the modified ElkSwift source under
`third-party-source/ElkSwift-WASI.tar.gz`; the release also supplies it as a
separate `ElkSwift-WASI-0.2.12.tar.gz` asset with a source-file manifest. It is
available under EPL-2.0 and belongs outside the hosted `site/` directory.

The [distribution manifest](0.2.12/MANIFEST.json) records every consumer-package
file. No engine or app Swift source is part of the browser runtime.
