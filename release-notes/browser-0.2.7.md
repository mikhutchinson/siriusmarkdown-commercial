# SiriusMarkdown browser 0.2.7

October 20, 2026

Find keeps its active result visible when an image finishes loading or prepared
layout changes. Highlights rebind to the same authored source after text nodes
are replaced. The reader reveals the result without moving the surrounding page;
scrolling, touch navigation and text selection relinquish automatic following.
Geometry-only changes reuse existing highlights, avoiding repeated work in
documents with many search results.

Clearing Find or retiring the document releases its geometry observation.
The shared Swift engine, WASM reactors, native SDK 0.7.9, diagram geometry and
export typography are unchanged. Upgrade consumer JavaScript together with the
matching worker, fonts and modules from this browser package.
