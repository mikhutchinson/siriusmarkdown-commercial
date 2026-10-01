# macOS Quick Look containing app and extension

This example builds a real `.app` containing `Contents/PlugIns/MarkdownPreviewExtension.appex` and an **actual `QLPreviewView` host**. The host never instantiates SiriusMarkdown itself. macOS chooses the preview provider, making the host useful for discovering conflicts and differences from Finder. Adding the package dependency alone does **not** install a Quick Look extension.

## Build and install locally

Requires Xcode with its command-line tools selected, macOS 13 or newer, and the repository's local package. The checked-in Xcode project builds without XcodeGen. To change the project, edit `project.yml` and regenerate with `xcodegen generate` in this directory.

```sh
Examples/QuickLookPreview/scripts/build.sh
Examples/QuickLookPreview/scripts/install.sh
```

The default build is ad-hoc signed, with a sandboxed extension and an outgoing
network entitlement for the SDK's bounded image and favicon loaders. The
containing example app is unsandboxed so it can open command-line fixture paths.
A sandboxed adopting app should use a user-selected file URL; the extension has
its own sandbox.

The install script copies the app to `~/Applications`, registers it with Launch Services and opens it. It refuses to overwrite an existing installation. Enable **SiriusMarkdown** under **System Settings → General → Login Items & Extensions → Quick Look** (the location varies by macOS version). Development registration does not constitute an end-user distribution installer. Do not infer that a registered or enabled provider was selected for a file.

To inspect registration:

```sh
pluginkit -m -A -D -i dev.swiftpython.SiriusMarkdownPreview.PreviewExtension
mdls -name kMDItemContentType -name kMDItemContentTypeTree /absolute/path/document.md
```

To remove this example, quit the host and remove only the installed `SiriusMarkdownPreview.app`; macOS removes its extension registration. Do not disable competing extensions merely to make a test pass. Record their enabled state and test with that state intact.

## Integrate into another app

1. Add the SiriusMarkdown package and the `SiriusMarkdownQuickLook` product to a **macOS Quick Look Preview Extension target**, not just the app target.
2. Define the extension's principal class:

   ```swift
   import SiriusMarkdownQuickLook
   final class PreviewViewController: MarkdownQuickLookPreviewController {}
   ```

3. Copy the `NSExtension` structure from `Extension/Info.plist`, retaining `com.apple.quicklook.preview`, `QLIsDataBasedPreview = false`, the module-qualified principal class and the supported Markdown content types.
4. Import the existing Markdown type in the containing app (`UTImportedTypeDeclarations`), with `public.plain-text` conformance and filename/MIME tags. Do not export a new owner for the community Markdown type. This example declares `net.daringfireball.markdown` and accepts `public.markdown` if the OS or another installed app supplies it. Check the actual file's type on the target machine.
5. Enable `APPLICATION_EXTENSION_API_ONLY`, App Sandbox, user-selected read-only
   file access and outgoing network connections for the extension. Preserve the
   SDK's resource policies; broad filesystem exceptions are unnecessary.
6. Embed the extension target in the app's **Embed App Extensions** copy phase with destination **PlugIns**. Link only extension-safe dependencies. The build script applies extension-safety flags to package Swift and C compilation too.
7. Give your app/extension your own distinct bundle identifiers and sign both with the same team. Preserve all required embedded SDK frameworks and their resources; the bundled fonts are required for native math.

Quick Look selection is system-controlled. Neither `QLPreviewView` nor the Finder preview API exposes a public way to force this specific provider. Multiple registered Markdown extensions can compete. An app needing guaranteed inline Markdown rendering can adopt SiriusMarkdown directly, but that is a separate UI path and is not evidence that Quick Look routing works.

## Signing and distribution

For a Developer ID build, supply the actual identity and team:

```sh
SIGN_IDENTITY='Developer ID Application: Your Organization (TEAMID)' \
DEVELOPMENT_TEAM=TEAMID Examples/QuickLookPreview/scripts/build.sh
```

Use a real Apple developer signing identity for distribution; ad-hoc signatures are a local test convenience. Sign the embedded extension and then the containing app, retain the hardened runtime, verify nested signatures, archive/notarize your distribution with Apple's current tools, and staple the accepted ticket. This example does not submit, notarize or publish anything. Distribute the containing app rather than the `.appex` by itself. Mac App Store distribution additionally needs the app's sandbox, provisioning and App Store requirements; the unsandboxed test host is not an App Store-ready app.

Keep the signing identity consistent when updating an installed extension.
Replacing a Developer ID signed extension with an ad-hoc build can cause a
container-access prompt before preview code starts. Use the same identity and
team for the replacement; do not grant access to a different identity to fix it.

## Live verification and stress fixtures

```sh
Examples/QuickLookPreview/scripts/make-fixtures.py /tmp/sirius-markdown-ql-fixtures
open -a "$HOME/Applications/SiriusMarkdownPreview.app" --args \
  /tmp/sirius-markdown-ql-fixtures/Formatting.md \
  /tmp/sirius-markdown-ql-fixtures/Long-10000.md \
  /tmp/sirius-markdown-ql-fixtures/Malformed.md \
  --stress=100 --interval=0.15 --evidence=/tmp/sirius-ql-host.jsonl
```

Quit an existing host before launching with new arguments. The toolbar supports opening files, switching, closing/recreating the preview and changing appearance. A stress run switches repeatedly and closes/recreates the `QLPreviewView` every third step. The host writes assignment and dismissal events plus its maximum 50 ms main-run-loop heartbeat gap. That number measures **host responsiveness only**; it does not measure extension rendering completion or memory. Collect extension process/log evidence separately, including bundle ID and render completion before claiming selection. The host title and its status label intentionally say that macOS selects the provider.

Also select `Formatting.md` in Finder and press Space. Capture Finder and QLPreviewView separately in light/dark appearance, select/copy text, scroll long documents, repeatedly dismiss/reopen, and retain evidence of which extension actually ran. A standalone render or screenshot of this host's chrome is not proof of provider selection.

`Formatting.md` references a generated `local-image.png` sibling. Relative images
load when the extension has access; a document grant does not automatically grant
access to neighboring files. Missing, inaccessible and symlinked images retain
placeholders. Public HTTPS images and icons use the shared bounded loader, but
Quick Look's system sandbox may deny networking despite the network entitlement.
In that case images retain placeholders and links retain native glyphs.
`Capabilities.md` exercises remote photography, diagrams, charts, math and HTML.

`Unsupported.md` contains malformed UTF-16, `UTF16.md` valid BOM-marked UTF-16, `Empty.md` is empty, `Malformed.md` has incomplete Markdown, and `Huge.md` supplies 17 MiB of adversarial single-line input. Outcomes and limits are documented with the reusable module. Verify these in the installed extension as well as its unit tests.

## Apple references

- [Create a custom Quick Look preview](https://developer.apple.com/documentation/quicklook/creating-quick-look-previews-for-custom-file-types)
- [QLPreviewingController](https://developer.apple.com/documentation/quicklookui/qlpreviewingcontroller)
- [QLPreviewView](https://developer.apple.com/documentation/quicklookui/qlpreviewview)
- [Declaring new uniform type identifiers](https://developer.apple.com/documentation/uniformtypeidentifiers/defining-file-and-data-types-for-your-app)
- [App extension distribution and development](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/ExtensionCreation.html)
- [Notarizing macOS software before distribution](https://developer.apple.com/documentation/security/notarizing-macos-software-before-distribution)

The view-based Info.plist keys and API signatures were checked against the installed Xcode 26.6 Quick Look Preview Extension template and macOS SDK headers. The example does not include `QLPreviewProvider` data-based fallback or legacy `.qlgenerator` code.

## Controlled competing provider

`CompetitionFixture` is a separate optional containing app and extension. Build it with `scripts/build-competition-fixture.sh`; the main scheme does not embed it. It advertises the same Markdown UTIs and shows a conspicuous orange **COMPETING MARKDOWN PREVIEW** banner when selected. Its identifier is `dev.swiftpython.SiriusMarkdownCompetitionFixture.PreviewExtension`. Copy `CompetitionFixture.app` from the build products to a test Applications folder, open it, and enable it in Quick Look settings to run the two-provider experiment. Record provider registration/enabled state before and after the test. Remove that test app afterward. This tests competition with a controlled provider; it is not a claim of compatibility with any third-party Markdown extension.
