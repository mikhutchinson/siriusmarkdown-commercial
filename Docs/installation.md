# Installation and packaging

Add `https://github.com/mikhutchinson/siriusmarkdown-commercial.git` in Xcode,
select version 0.7.4 or later, and link the `SiriusMarkdown` product. Product
and import names match the source SDK. Narrower products are listed in the
[architecture guide](architecture.md#choose-a-product).

The SDK requires Swift 6.3 or later. Included platform slices support macOS 13,
iOS/iPadOS 16 and visionOS 1, with device and simulator
variants where applicable. `SiriusMarkdownQuickLook` is a macOS product.
Native math and Mermaid diagrams are available on macOS, iOS and visionOS.
This binary distribution does not include tvOS or watchOS slices.

## Resources

Math fonts, highlighting and diagram runtimes, and layout fixtures are bundled
inside `SiriusMarkdownSupport.framework`. Xcode links and embeds the required
frameworks when you add a package product. No separate resource-copy step is
needed.

If you manually assemble an application or extension, embed and sign every
framework listed by your product, preserving each framework's directory
structure and resources. On macOS, frameworks belong in `Contents/Frameworks`;
on iOS and visionOS, use the application's `Frameworks` directory.

Missing fonts cause supported equations to retain source text. Missing
highlighting or fallback runtimes retain plain code or diagram source. Check
these behaviors in the packaged application, including its extensions.

## Binary dependencies

The manifest references versioned HTTPS XCFramework archives with SwiftPM
checksums. Each artifact contains compiled dynamic frameworks and standard public
Swift interfaces. Implementation dependencies are linked automatically; hosts
do not add parser or diagram packages separately.

Public interfaces describe the API without requiring implementation source.
The SDK's [hosted API reference](https://siriusmarkdown.com/api/documentation/siriusmarkdown/)
provides searchable declarations. Read documentation at the version you use.

For signed distribution, use your application's normal signing and notarization
process. Linking the SDK does not install the [Quick Look extension](QuickLook.md).

## Switching over public enums

The SDK uses library evolution. When switching over a public enum, include an
`@unknown default` branch to handle future cases. Pattern matches using `if case`
do not need that branch. The bundled examples demonstrate both forms.
