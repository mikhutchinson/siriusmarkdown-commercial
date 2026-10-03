# ``SiriusMarkdownSwiftUI/MarkdownDocumentFindBar``

Native Find controls for a document or host-scrolled transcript.

## Overview

Supply a ``MarkdownDocumentFindController`` with a prepared index. A host-scrolled reader owns revealing the controller’s current match; the bar supplies query, case matching and previous/next controls.

### SwiftUI integration

This type conforms to SwiftUI’s `View` protocol. Standard modifiers such as
`padding`, `frame`, `opacity` and `environment` remain available. See Apple’s
[View reference](https://developer.apple.com/documentation/swiftui/view) and
[view configuration guide](https://developer.apple.com/documentation/swiftui/view-configuration)
for inherited modifiers. SiriusMarkdown-specific declarations appear in Topics below.

## See Also

- ``MarkdownDocumentFindController``
