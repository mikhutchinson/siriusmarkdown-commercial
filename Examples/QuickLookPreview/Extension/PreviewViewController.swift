import SiriusMarkdownQuickLook

/// Keep the extension principal class in the extension executable so Quick Look
/// can instantiate it by its module-qualified name from Info.plist.
final class PreviewViewController: MarkdownQuickLookPreviewController {}
