# Native mathematics

The document and chat presets typeset inline and display mathematics by default
on macOS, iOS and visionOS. Use `$…$` or `\(…\)` for inline equations and a
standalone `$$` or `\[…\]` fence for display equations. The renderer preserves
the original LaTeX for copying and prepares semantic accessibility structure
alongside the image and its baseline metrics.

```markdown
The variance is $\sigma^2 = \mathbb E[(X-\mu)^2]$.

$$
\underbrace{p(\theta\mid x)}_{\text{posterior}}
= \frac{\overbrace{p(x\mid\theta)}^{\text{likelihood}}p(\theta)}
       {\int p(x\mid t)p(t)\,dt}
$$
```

Explicit math delimiters preserve underscores, asterisks and backslashes within
the equation even when CommonMark would interpret them as emphasis or escapes.
Code spans keep their literal text. Surrounding Markdown emphasis and link
context remain available to the renderer.

Display equations wider than their available space use horizontal scrolling.
A paragraph containing an oversized inline equation also gains a horizontal
viewport, keeping the complete equation accessible at its native font size.
Widening the view restores ordinary paragraph layout without typesetting again.

## Equations and structure

The native engine supports fractions, roots, scripts, Greek symbols, named
operators, accents, matrices, aligned equations, cases and nested expressions.
It also supports:

- `\underbrace` and `\overbrace`, including labels and braces inside fractions.
- `\overset`, `\underset` and `\stackrel`, with labels above or below the base.
- `\substack` for multiline operator limits.
- `\dfrac`, `\tfrac`, `\dbinom` and `\tbinom` for explicit display or text style.
- `\cfrac` for continued fractions with display-style components.
- `\phantom` for invisible spacing and `\boldsymbol` for bold italic variables.
- `\operatorname` and `\operatorname*` for named operators and display limits.

See the [complex mathematics example](../Examples/Fixtures/complex-math.md)
for complete inline and display expressions from physics, statistics and linear
algebra. This supported subset is not a complete TeX document processor: custom
macro definitions, package loading and arbitrary LaTeX commands are not available.
Unsupported input retains its source and increments `mathFallbackCount` in the
configuration's diagnostics recorder.

## Resolution and preparation

The engine draws native glyphs and rules directly at the requested raster scale.
The default follows the platform backing scale, with a minimum of 2×. For a
higher-resolution export, prepare with an explicit scale:

```swift
var configuration = MarkdownRendererConfiguration.document
configuration.mathRenderer = DefaultMarkdownMathRenderer(rasterizationScale: 4)
let prepared = configuration.prepare(snapshot: snapshot)
```

Scales up to 8× are supported. Increasing scale increases pixel count without
changing the equation's font size in points; dimensions round up to whole pixels.
Prepared bounds include glyph overhangs and baseline space so the image can sit
within native text without clipping. Font sizes are bounded at 512 points, and
individual rasters are bounded at 16,384 pixels per dimension and 16,777,216
pixels in total. Requests outside the supported bounds retain source fallback.

Typesetting, rasterization and decoding happen during preparation. Resizing a
prepared document reuses the math image and its measured baseline. Scale and
typesetter identity participate in the bounded preparation cache. Preserve the
package resource bundles, including math fonts, when packaging an application.

Use `PlainMarkdownMathRenderer` when your host intentionally displays LaTeX source.
