# ``SiriusMarkdownSwiftUI/MarkdownBlockView``

A native renderer for an individual Markdown block.

## Overview

Use this view when composing a custom block host. Supply its prepared block content and renderer configuration; for a complete document, prefer ``MarkdownDocumentView`` or ``StreamingMarkdownView``.

### SwiftUI integration

This type conforms to SwiftUI’s `View` protocol. Standard modifiers such as
`padding`, `frame`, `opacity` and `environment` remain available. See Apple’s
[View reference](https://developer.apple.com/documentation/swiftui/view) and
[view configuration guide](https://developer.apple.com/documentation/swiftui/view-configuration)
for inherited modifiers. SiriusMarkdown-specific declarations appear in Topics below.

## See Also

- ``MarkdownPreparedBlockContent``
