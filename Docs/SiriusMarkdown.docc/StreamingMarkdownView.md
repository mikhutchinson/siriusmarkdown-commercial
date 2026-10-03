# ``SiriusMarkdownSwiftUI/StreamingMarkdownView``

A Markdown content view for a host-scrolled document or streaming reply.

## Overview

Observe a long-lived ``MarkdownRenderSession`` and pass its prepared snapshot and configuration to this view. Place the view inside your own scroll container. For a document reader with its own scrolling, use ``MarkdownDocumentView``.

### SwiftUI integration

This type conforms to SwiftUI’s `View` protocol. Standard modifiers such as
`padding`, `frame`, `opacity` and `environment` remain available. See Apple’s
[View reference](https://developer.apple.com/documentation/swiftui/view) and
[view configuration guide](https://developer.apple.com/documentation/swiftui/view-configuration)
for inherited modifiers. SiriusMarkdown-specific declarations appear in Topics below.

## See Also

- ``MarkdownRenderSession``
