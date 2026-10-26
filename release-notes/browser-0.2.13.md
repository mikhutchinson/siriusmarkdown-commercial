# SiriusMarkdown Browser 0.2.13

Both WebAssembly reactors include the shared engine from native SDK 0.7.21.
The consumer manifest records that native version and the engine source hash;
update the complete runtime together.

Inline publications now carry sanitized opaque sRGB text colors and exact
opening/closing style-source ranges. The browser renderer confines authored ink
to its text spans, retains theme styling for semantic links, and preserves color
in rich clipboard HTML and readable-print snapshots. Unsupported CSS does not
become browser styling or a resource request.

Moving earlier source text keeps unchanged styled paragraph nodes, selection
and their updated byte/line mappings. Changing a color updates the mounted
presentation. Streamed and complete input share the same semantic engine.

The release also includes composed inline highlight and task semantics from the
intervening native releases, while retaining the previously released inline-math
line-break and HTML list source-mapping behavior. Native viewport mounting,
AppKit/UIKit input and CoreText PDF APIs remain native integrations; this
browser package uses the documented worker, editing, clipboard and print APIs.
