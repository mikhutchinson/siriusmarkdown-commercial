# SiriusMarkdown Browser 0.2.15

Both WebAssembly reactors include the shared engine from native SDK 0.7.23.
The manifest records the native version and engine source hash. Update the
complete runtime together, including workers, JavaScript, fonts and both WASM
modules.

Partial semantic Copy preserves exactly the selected styled word without an
extra paragraph terminator. Selected spaces and authored line breaks remain,
and disjoint ranges keep a newline between their nonempty semantic fragments.
Partial words inside lists do not acquire unselected bullets, numbers or
checkboxes. HTML representations retain the selected styles. This matches the native
selection serializer; whole-document and readable-print paragraph structure
remain intact.

Browser APIs and native authoring APIs remain separate integrations. The native
caret, input geometry and prepared whitespace-row APIs do not replace browser
DOM editing or its source revision checks.
