# ``SiriusMarkdownSwiftUI/InlineRunsView``

A native inline text surface with configurable typography and interaction.

## Overview

For prepared layout, use the initializer that accepts ``MarkdownPreparedInlineContent``. Keep inline preparation outside view evaluation. The document and block views normally compose this surface for you.

### SwiftUI integration

This type conforms to SwiftUI’s `View` protocol. Standard modifiers such as
`padding`, `frame`, `opacity` and `environment` remain available. See Apple’s
[View reference](https://developer.apple.com/documentation/swiftui/view) and
[view configuration guide](https://developer.apple.com/documentation/swiftui/view-configuration)
for inherited modifiers. SiriusMarkdown-specific declarations appear in Topics below.

## See Also

- ``MarkdownPreparedInlineContent``
