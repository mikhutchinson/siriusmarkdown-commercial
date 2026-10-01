# Native macOS Quick Look integration

`SiriusMarkdownQuickLook` supplies a native preview controller for a macOS Quick
Look Preview Extension. It requires macOS 13 or newer.

A package dependency does not install an extension. Embed a preview extension
in a containing app, sign and install the app, then enable its provider in macOS.
The [example app and extension](../Examples/QuickLookPreview/README.md) provide
an Xcode project and build scripts.

## Add the extension

1. Add a **macOS Quick Look Preview Extension** target and link the
   `SiriusMarkdownQuickLook` product.
2. Declare the principal class in the extension executable:

   ```swift
   import SiriusMarkdownQuickLook

   final class PreviewViewController: MarkdownQuickLookPreviewController {}
   ```

3. Configure the extension using the example's
   [Info.plist](../Examples/QuickLookPreview/Extension/Info.plist). It declares
   `com.apple.quicklook.preview`, a module-qualified principal class,
   `QLIsDataBasedPreview = false`, `QLSupportsSearchableItems = false`, and
   the `net.daringfireball.markdown` and `public.markdown` content types.
4. Import the existing Markdown UTI in the containing app where needed. Avoid
   claiming ownership of the community type or registering all plain text.
5. Enable App Sandbox, user-selected read-only files and outgoing network
   connections for the extension. The network-client entitlement supports the
   renderer's bounded public-HTTPS images and site icons.
6. Enable `APPLICATION_EXTENSION_API_ONLY=YES` for the extension and compile
   linked dependencies with extension-safety checks. The example passes Swift
   `-application-extension` and C/Objective-C `-fapplication-extension`.
7. Embed the extension under `YourApp.app/Contents/PlugIns/YourPreview.appex`.
   Preserve the required SDK frameworks and their resources, including math fonts. Use your own bundle
   identifiers and sign the app and extension consistently with your team.

## Build and install the example

From the repository root:

```sh
Examples/QuickLookPreview/scripts/build.sh
Examples/QuickLookPreview/scripts/install.sh
```

The build defaults to ad hoc signing. The installer copies the app to
`~/Applications`, refuses to overwrite an existing app, registers it with Launch
Services and opens it. Enable **SiriusMarkdown** in **System Settings → General →
Login Items & Extensions → Quick Look**; the location varies on older macOS versions.

To inspect registration and a document's content type:

```sh
pluginkit -m -A -D -i dev.swiftpython.SiriusMarkdownPreview.PreviewExtension
mdls -name kMDItemContentType -name kMDItemContentTypeTree /absolute/path/document.md
```

Finder and `QLPreviewView` choose the provider. `QLPreviewView` has no public API
for forcing a specific extension bundle identifier, and other installed Markdown
providers can affect which preview appears. Check the installed extension in
both Finder and your app's preview host.

To uninstall the example, quit its host and remove its installed containing app.

## Signing and distribution

For Developer ID distribution, select your signing identity and team:

```sh
SIGN_IDENTITY='Developer ID Application: Your Organization (TEAMID)' \
DEVELOPMENT_TEAM=TEAMID Examples/QuickLookPreview/scripts/build.sh
```

Distribute the containing app with its embedded extension. Sign nested code and
the app consistently, retain hardened runtime and secure timestamps, notarize
the completed deliverable and staple the accepted ticket. The example scripts
do not perform notarization. Open the installed containing app to make its
extension available under Gatekeeper.

Mac App Store distribution requires the appropriate signing, provisioning and
sandbox configuration. The example's containing host is unsandboxed; its preview
extension is sandboxed. A sandboxed adopting app should retain its sandbox and
use file URLs obtained through authorized access.

## Rendering and interaction

The preview supports native Markdown, sanitized HTML, tables, highlighted code,
task lists, math and Mermaid diagrams. Visible sections use the shared
`MarkdownRenderSession`, including asynchronous images and link decorations.

Selection uses one document-wide controller. Select All and Copy include
offscreen sections without preparing them. Dragging uses the geometry of mounted
sections; word and paragraph selection and keyboard movement use the renderer's
native controls. Cross-window copying supplies complete Markdown and plain text,
omitting rich formats when the whole selection is not prepared.

The footer magnifier or Command-F opens Find. Heading and sanitized HTML fragment
links reveal their target blocks using a semantic anchor index, without preparing
offscreen content. Find builds its visible-text index on demand on a separate
worker and selects the active result. `buildDocumentIndex()` lets a host request
the Find index before showing its own controls.

The host owns window chrome, dismissal and item navigation. Check keyboard
focus, selection, scrolling, light/dark appearance and VoiceOver in that host.

## Large documents and lifecycle

The controller reads and parses the complete document, then groups it into
preparation windows of up to 32 top-level semantic blocks. Windows prepare as
needed for the viewport and release their prepared state when unloaded. Estimated
heights reserve scroll space until measured heights are available.

Source and semantic-model memory still grow with the document. A large table,
list or paragraph remains one block. The controller applies no source-byte
truncation limit; the public file loader offers an optional limit for hosts
that choose one and reports truncation in its result.

Disappearance or document replacement cancels pending work and rejects stale
results. `cancelPreview()` is available for custom lifecycle integrations.
Cancellation is checked between reads, semantic stages and prepared blocks;
a synchronous parser call must finish before cancellation takes effect.

`waitUntilPrepared()` awaits source reading and semantic parsing, not viewport
preparation or first paint. `lastMetrics` describes reading and parsing;
`prepareSeconds` is zero and must not be used as a viewport rendering time.

The preview uses a centered reading column that fits narrow windows and stops
growing at 640 points. Diagram expansion stays beside each figure; source,
export and zoom actions are grouped in the shared diagram menu. Find remains
available from the magnifying glass or Command-F.

## Encodings and resources

The loader accepts UTF-8 with or without BOM and BOM-marked UTF-16. Invalid or
unsupported encoding, embedded NUL, unreadable files and non-regular files
produce an error explanation.

Public HTTPS images and site icons use the same bounded, anonymous
resolvers as the SDK. The macOS Quick Look sandbox can prohibit networking even
with the outgoing-network entitlement; unavailable images retain placeholders
and links retain native glyphs. The entitlement alone does not guarantee downloads.
Requests begin for prepared viewport sections and are cancelled when those
sections leave the view. HTML passes through native
sanitization; scripts, active embeds and arbitrary CSS do not execute.

Document-relative raster images load during preparation when sandbox access
permits. `DefaultMarkdownImageResolver(documentURL:)` combines this local path
with the default remote loader. The local resolver rejects absolute paths,
URL schemes, parent traversal and symlinks in referenced components.

Accepted images are single-frame PNG, JPEG, GIF and TIFF, subject to all of these
limits: 8 MiB encoded size, 12,000 pixels per axis, and 50,000,000 total pixels.
The cache holds at most eight entries and 8 MiB of encoded data. Eviction allows
other images to load; it does not cap the document's total image count or decoded
memory.

The extension needs sandbox access to every referenced file. Access to
`note.md` does not imply access to sibling `image.png`, and security-scoped
access cannot create a missing grant. Missing, inaccessible or refused images
retain placeholders. Exercise this behavior in the installed extension.

## Local-file link decoration

Relative links use native symbols inferred from their filename type: source
code, text, images, audio, movies, archives, PDF or a generic document. A trailing
slash indicates a folder. These hints do not read the target or establish that
it exists. HTTP(S) links retain website decoration regardless of filename.

This behavior is shared with the renderer's `.automatic` link decoration.
Custom fallback configurations can opt in with `usesDestinationSymbols`.
