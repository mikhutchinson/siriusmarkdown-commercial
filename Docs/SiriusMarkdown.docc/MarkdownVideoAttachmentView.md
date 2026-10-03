# ``SiriusMarkdownSwiftUI/MarkdownVideoAttachmentView``

A prepared video poster with user-initiated native playback.

## Overview

The host supplies the authorized video URL and ``MarkdownPreparedVideo``. The view presents the prepared poster until playback is requested; it does not autoplay. Its `playRequest` parameter also lets a host action request playback.

### SwiftUI integration

This type conforms to SwiftUI’s `View` protocol. Standard modifiers such as
`padding`, `frame`, `opacity` and `environment` remain available. See Apple’s
[View reference](https://developer.apple.com/documentation/swiftui/view) and
[view configuration guide](https://developer.apple.com/documentation/swiftui/view-configuration)
for inherited modifiers. SiriusMarkdown-specific declarations appear in Topics below.

## See Also

- ``MarkdownPreparedVideo``
