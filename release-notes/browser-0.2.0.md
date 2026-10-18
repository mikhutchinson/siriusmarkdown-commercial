# SiriusMarkdown browser 0.2.0

October 18, 2026

Edit and resize inline Markdown and policy-authorized HTML images with
source-backed Undo. HTML images also support alternative-text editing.
Explicit standalone Markdown figures can wrap prepared prose around the image
and its caption; narrow columns clear the prose below the figure.

Readable table print snapshots continue wide tables across column groups and
pages while repeating identifying columns and headings. They retain the original
text size, merged-cell contents, loaded pictures and equation vectors without
changing the interactive reader.

The browser keeps unchanged content through source edits, anchors contextual
controls to visible content, and preserves diagram viewer geometry, scroll and
focus. The website waits for prepared layout before revealing a switched
example and keeps its readiness indicator in step with source edits and Undo.

The download includes an optional bounded Node resource gateway for self-hosted
integrations that need public pictures and icons without CORS headers. The public
playground stays on static GitHub Pages hosting and uses direct browser requests,
so its cross-origin resources still require readable CORS responses.

[Download browser 0.2.0](https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/tag/browser-0.2.0)
or try the [playground](https://siriusmarkdown.com/playground/). Follow the
[web page API](../Docs/web-page-api.md) for worker initialization, fonts,
resource ownership, editing and print integration.

The browser package contains compiled WASM reactors and consumer JavaScript,
fonts and notices. Keep its modified ElkSwift corresponding-source archive and
license terms intact. Engine implementation source is excluded.

This release targets current desktop Safari, Chrome and Firefox. It does not
claim complete native capability parity or exhaustive mobile-device coverage.
Browser clipboard formats and printing differ from native pasteboard and PDF
APIs; publication column regions and native PDF export options remain separate.
The native Swift SDK remains 0.7.6 with its existing XCFramework products.
