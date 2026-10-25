# ``SiriusMarkdownSwiftUI/StreamingMarkdownView``

A Markdown content view for a host-scrolled document or streaming reply.

## Overview

Observe a long-lived ``MarkdownRenderSession`` and pass its prepared snapshot and configuration to this view. Place the view inside your own scroll container. For a document reader with its own scrolling, use ``MarkdownDocumentView``.

On macOS, read-only streams mount native content around the host's viewport,
keeping stable offscreen scroll destinations and prepared interaction state.
Host-boundary views remain mounted. Rendered editing retains its complete input
geometry. Use ``offscreenContent(_:)`` with
``MarkdownOffscreenContentPolicy/retained`` when custom styles need every
offscreen view to remain mounted. Other platforms keep their existing automatic
streaming lifecycle.

### SwiftUI integration

This type conforms to SwiftUI’s `View` protocol. Standard modifiers such as
`padding`, `frame`, `opacity` and `environment` remain available. See Apple’s
[View reference](https://developer.apple.com/documentation/swiftui/view) and
[view configuration guide](https://developer.apple.com/documentation/swiftui/view-configuration)
for inherited modifiers. SiriusMarkdown-specific declarations appear in Topics below.

## See Also

- ``MarkdownRenderSession``
