# ``SiriusMarkdownSwiftUI/MarkdownDocumentView``

A scrollable reader for an already-prepared Markdown document.

## Overview

Prepare a snapshot with ``MarkdownRendererConfiguration`` before passing it to the `preparedSnapshot:` initializer. Keep parsing, resource resolution, highlighting and measurement outside SwiftUI view evaluation. Use ``StreamingMarkdownView`` when the host owns scrolling.

### SwiftUI integration

This type conforms to SwiftUI’s `View` protocol. Standard modifiers such as
`padding`, `frame`, `opacity` and `environment` remain available. See Apple’s
[View reference](https://developer.apple.com/documentation/swiftui/view) and
[view configuration guide](https://developer.apple.com/documentation/swiftui/view-configuration)
for inherited modifiers. SiriusMarkdown-specific declarations appear in Topics below.

## See Also

- ``MarkdownRendererConfiguration``
