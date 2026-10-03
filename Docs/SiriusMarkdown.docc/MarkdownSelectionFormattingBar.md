# ``SiriusMarkdownSwiftUI/MarkdownSelectionFormattingBar``

A command bar for host-owned formatting actions.

## Overview

Supply the available ``MarkdownFormattingCommand`` values and handle the selected command in the callback. The host owns source edits and Undo; the bar presents commands without editing the document.

### SwiftUI integration

This type conforms to SwiftUI’s `View` protocol. Standard modifiers such as
`padding`, `frame`, `opacity` and `environment` remain available. See Apple’s
[View reference](https://developer.apple.com/documentation/swiftui/view) and
[view configuration guide](https://developer.apple.com/documentation/swiftui/view-configuration)
for inherited modifiers. SiriusMarkdown-specific declarations appear in Topics below.

## See Also

- ``MarkdownFormattingCommand``
