# SiriusMarkdown Compare

[Download the macOS app](https://siriusmarkdown.com/compare/download/) or open the [1.0.0 release](https://github.com/mikhutchinson/siriusmarkdown-commercial/releases/tag/compare-1.0.0).

SiriusMarkdown Compare 1.0.0
https://siriusmarkdown.com

Native Swift, Sirius WASM and Pele — one shared Mermaid source.

Requires macOS 15 or later. Universal app for Apple silicon and Intel.
Drag SiriusMarkdown Compare to Applications, then open it normally.

Choose an example and click Render or Stream. Source lets you edit the shared
Mermaid input or open a UTF-8 source file up to 64 KiB. Every pane receives the
same source. The sixteen examples are a curated set, not a complete compatibility
test of any renderer. Inspect the visible output as well as the timing numbers.

Total render wait accumulates wall time with input awaiting a successful scene
update. Errors and later successful calls cannot erase earlier waiting. Streaming
pauses count while a pane is behind. Longest wait preserves stalls. Last rendered
call measures one successful call. These are preparation/publication timings;
display painting is excluded. The native and browser endpoints do different work,
so these numbers are not a CPU microbenchmark ranking.

The app bundles the released SiriusMarkdown Swift SDK 0.7.7, browser 0.2.1 and
the official, unmodified Pele 1.6.0 npm module. All renderer resources load from
the app. A read-only server binds only an ephemeral loopback address. The app
does not upload your source or results. Website links open in your browser.

Reset clears a take while keeping runtimes and caches loaded. New take restarts
the app and workers, preserving your source and appearance. Caches can warm
during a take. The streaming feed targets twelve seconds; actual feed duration
is displayed.

Export results saves the exact source, hashes, release provenance, counts and
timing records to a JSON file you choose. Help > Timing and Methodology explains
the endpoints and source-coverage counters. Help > Licenses and Notices opens
the SDK, browser, font and Pele licenses and corresponding-source information.

SiriusMarkdown Compare is made by Mikholae Hutchinson. Pele is a separate project
by kepano; its inclusion does not imply endorsement. Third-party runtimes and
fonts retain their respective licenses.

© 2026 Mikholae Hutchinson.

[Dependency provenance](dependencies.json) records the bundled release archives and hashes. [Example sources](fixtures.json) match the sixteen inputs bundled in the app.
