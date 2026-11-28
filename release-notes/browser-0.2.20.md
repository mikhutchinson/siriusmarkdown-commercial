# SiriusMarkdown Browser 0.2.20

- Enforce a typographic line-height minimum when browser consumers configure tight line heights without explicit font ascent/descent metrics.
- Preserve CSS `line-height` vertical centering when published `lineDescent` is zero instead of pinning the baseline to the bottom edge of the row.
- Build both WASM reactors from the shared SiriusMarkdown 0.7.28 source.
