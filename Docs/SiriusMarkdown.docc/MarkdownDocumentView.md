# ``SiriusMarkdownSwiftUI/MarkdownDocumentView``

A scrollable reader for an already-prepared Markdown document.

## Overview

Prepare a snapshot with ``MarkdownRendererConfiguration`` before passing it to the `preparedSnapshot:` initializer. Keep parsing, resource resolution, highlighting and measurement outside SwiftUI view evaluation. Use ``StreamingMarkdownView`` when the host owns scrolling.

On macOS, content mounts around the viewport while offscreen items retain their stable scroll destinations and measured heights. Source-backed selection survives scrolling away and back. Code collapse, diagram source and camera choices, and explicitly started video sessions remain associated with their source.

### SwiftUI integration

This type conforms to SwiftUI’s `View` protocol. Standard modifiers such as
`padding`, `frame`, `opacity` and `environment` remain available. See Apple’s
[View reference](https://developer.apple.com/documentation/swiftui/view) and
[view configuration guide](https://developer.apple.com/documentation/swiftui/view-configuration)
for inherited modifiers. SiriusMarkdown-specific declarations appear in Topics below.

## See Also

- ``MarkdownRendererConfiguration``
