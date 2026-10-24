# SiriusMarkdown Browser 0.2.12

October 24, 2026

Both WebAssembly reactors now include the shared engine from native SDK 0.7.14.
Paragraphs containing inline equations and source line breaks retain one copy of
their prose, with exact authored break ranges. HTML list items retain their own
source occurrences across inline and structured projections, including CRLF,
character references and streamed input.

The consumer manifest records the matching native SDK version and engine source
hash. Keep the JavaScript, workers, fonts and reactors from one download together.
The website build rejects mismatched native and browser provenance.

Browser editing, outline navigation, source-backed selection and readable table
printing retain their existing APIs. CoreText PDF pagination and AppKit/UIKit
input interfaces are native SDK APIs; browsers continue to use their own input,
clipboard and print systems. Static hosting and direct-resource CORS limits are
unchanged. The native SDK remains 0.7.14.
