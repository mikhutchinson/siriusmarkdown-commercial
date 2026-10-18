# SiriusMarkdown for the browser

Browser 0.1.1 is the SiriusMarkdown browser/WASM MVP. It is distributed
separately from the native Swift XCFramework SDK in this repository.

- [Download browser 0.1.1](https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/tag/browser-0.1.1)
- [Interactive playground](https://siriusmarkdown.com/playground/)
- [Integration guide](https://siriusmarkdown.com/docs/browser/)
- [Page and worker API](0.1.1/Browser-API.md)
- [Runtime notices](0.1.1/NOTICE.md)
- [Archive checksums](0.1.1/SHA256SUMS.txt)

Extract `SiriusMarkdown-browser-0.1.1.zip` and serve its `site/` directory over
HTTPS, or localhost for development. Keep `js`, `assets`, `dist` and `playground`
together. Serve `.wasm` as `application/wasm`, module JavaScript as
`text/javascript`, and fonts with appropriate font MIME types. Open the included
playground as a complete reference host, or integrate its worker and presentation
modules using the page API above.

The browser uses the actual SiriusMarkdown engine for Markdown/GFM structure,
streamed documents, sanitized rich HTML, native-engine vector equations and the
documented Mermaid subset. Images, tables, highlighted code, selection, rich
copy, exact-source Copy Markdown and host-owned formatting use the same authored
source. Unsupported completed diagram syntax retains its source fallback.

The main reactor is about 58 MiB and the separate diagram reactor about 56 MiB
before HTTP compression. Load them when needed and cache a complete version's
matching modules, workers, JavaScript and fonts together. Your marketing or
navigation pages do not need to download the engines.

Version 0.1.1 retains unchanged content while editing, including decoded pictures
and vector equations and diagrams. Source positions stay current for selection,
copy and image actions.

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
contexts and arbitrary CSS are not enabled. Standalone Markdown images support contextual editing and host-owned drag resizing
with Undo. Inline/HTML image editing and prepared text-wrapping controls are outside
this release.

Browser HTML/custom clipboard formats differ from native pasteboard types.
Use Copy Markdown to transfer exact authored source as plain text. Printing and
PDF pagination use the browser's print system and differ from native PDF export.

## License and corresponding source

Preserve Commercial SDK License 1.0, prior MIT grants, third-party notices and
font/runtime licenses. They are included in the download and retain their own
terms. The download includes the modified ElkSwift source under
`third-party-source/ElkSwift-WASI.tar.gz`; the release also supplies it as a
separate `ElkSwift-WASI-0.1.1.tar.gz` asset with a source-file manifest. It is
available under EPL-2.0 and belongs outside the hosted `site/` directory.

The [distribution manifest](0.1.1/MANIFEST.json) records every consumer-package
file. No engine or app Swift source is part of the browser runtime.
