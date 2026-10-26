# SiriusMarkdown Browser 0.2.14

Both WebAssembly reactors include the shared engine from native SDK 0.7.22.
The manifest records that version and the engine source hash. Update the complete
runtime together.

Entity and escape spellings retain their authored source ranges through
preparation, highlight processing, selection metadata and semantic copy. A host
can split a highlight without losing entity text or exposing its delimiters.
Encoded equals signs and dollar signs remain literal, and NUL replacement
preserves later source positions.

Inline-code publications include exact opening and closing `styleSources`,
including backticks and padding omitted by the semantic parser. The code run's
source range still covers its whole token. Hosts must check source revisions,
keep style delimiters outside literal code and preserve each boundary's authored
spelling. These ranges do not authorize rewriting link destinations or guessing
missing syntax.

The supplied renderer, semantic clipboard and readable-print snapshots preserve
the corrected text and styles. Shared-engine `sourceTextMappings` keep partial
copy and DOM selection exact across entities, escapes and invisible code syntax,
including wrapped spans and retained content after source relocation.
Native platform editing and export integrations
remain separate from these browser APIs.
