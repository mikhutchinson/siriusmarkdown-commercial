# ``SiriusMarkdownSwiftUI/MarkdownBlockStyleLabel``

An already-prepared block label supplied to a block style.

## Overview

Compose this label inside your style’s `makeBody(configuration:)` to customize presentation around native content. Styles decorate the supplied label; they must not parse Markdown or repeat preparation.

### SwiftUI integration

This type conforms to SwiftUI’s `View` protocol. Standard modifiers such as
`padding`, `frame`, `opacity` and `environment` remain available. See Apple’s
[View reference](https://developer.apple.com/documentation/swiftui/view) and
[view configuration guide](https://developer.apple.com/documentation/swiftui/view-configuration)
for inherited modifiers. SiriusMarkdown-specific declarations appear in Topics below.

## See Also

- ``MarkdownDocumentStyle``
