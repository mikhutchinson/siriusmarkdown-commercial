# Integration checklist

Use this checklist when adding SiriusMarkdown to an application. The linked
guides describe the relevant configuration and platform behavior.

## Rendering and resources

- Pass prepared snapshots to the views and keep parsing, highlighting and
  resource preparation outside SwiftUI view evaluation.
- Preserve package resource bundles in the packaged app, including math fonts.
- Exercise the document structures your app accepts: tables, code, equations,
  HTML, links and images, at narrow and wide reading widths.
- Check unsupported math and [diagram syntax](Native-Mermaid.md#syntax-and-limits)
  so their source fallbacks fit your interface.
- Choose image and link policies explicitly where your app's requirements
  differ from the defaults. Public HTTPS images load by default; set
  `LocalOnlyMarkdownImagePolicy` to opt out. Relative files require a host-owned
  base directory and authorized filesystem access.

## Interaction and export

- Try selection, copy, Find, keyboard navigation, light and dark appearance,
  and VoiceOver with your app's controls and scroll containers.
- Validate source revisions before applying formatting, image or table edits;
  keep transactions and Undo in the host.
- Choose a PDF mode deliberately. Text-flow output supports selectable text;
  rasterized reader pages have fixed resolution and no selectable text or link
  annotations. Inspect the export's reported limitations.
- Profile representative documents on your target devices, including resizing,
  streaming, cancellation and document closure. See [performance](performance.md).

## Quick Look

Embed a signed preview extension in your containing application. Test the
installed extension in Finder and your adopting host with the Markdown file
types you support; macOS chooses the provider when several extensions are installed.

Quick Look uses the renderer's default bounded image and favicon loaders.
The system preview sandbox can deny networking even with the network-client
entitlement, so verify resource access in the installed extension.
Local-image loading requires sandbox access to each referenced file. Access to
the Markdown document does not automatically grant access to neighboring images.

See [Quick Look integration](QuickLook.md) for packaging, input limits, provider
selection and document-wide copying across preparation windows.
