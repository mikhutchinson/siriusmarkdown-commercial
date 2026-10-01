# SiriusMarkdown Quick Look

This **native Markdown preview** includes *emphasis*, ~~deletion~~, `inline code`, and [a link](https://example.com).

## Tasks and tables

- [x] Native text and selection
- [ ] Verify the selected extension in this host

| Feature | Example |
|:--|--:|
| Tables | 123 |
| Unicode | 日本語 · مرحبا · 🌙 |

```swift
struct Preview {
    let message = "Rendered with SiriusMarkdown"
}
```

> A block quote with **bold** text.

## Mathematics

Inline $E = mc^2$ and a display equation:

$$
\int_0^1 x^2\,dx = \frac{1}{3}
$$

## Untrusted resources

![Unavailable remote image retains a placeholder](https://example.com/never-fetch.png)

![Relative image, subject to sandbox access](local-image.png)

<script>alert('must never run')</script>

---

End of formatting fixture.
