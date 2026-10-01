# Figures and video attachments

Markdown images can carry width, alignment, caption, description, and wrapping
attributes. See [image interaction and wrapping](document-interactions.md#contextual-image-editing)
for responsive layout and host-owned edits. Native HTML figures share image and
caption preparation; arbitrary CSS layout is not interpreted.

## Local video

The SDK can present a prepared video attachment on macOS, iOS/iPadOS and visionOS.
A host supplies it through `MarkdownImageResolver` as
`MarkdownPreparedImageSource.video(url:poster:aspectRatio:)`. Use a standalone
Markdown image reference for a video block, for example:

```markdown
![Launch sequence](media/launch.mov){width=70% caption="A local recording."}
```

The default image resolver does not turn movie paths into playable attachments.
Your resolver must authorize the source and provide a file URL that the host can
access. `LocalMarkdownVideoResolver(documentURL:limits:)` can prepare a poster
for a document-relative video. It refuses absolute paths, parent traversal and
remote URLs. Its default poster preparation bounds are 256 MiB of input and
2,048 pixels per poster dimension. A missing or unreadable poster retains a
16:9 fallback box; a fallback poster does not establish that playback will work.

The prepared block reserves its aspect ratio as the viewport changes. The native
player opens the supplied URL only after the reader asks to play. It does not
autoplay. Captions and image-interaction hooks remain available. The host retains
file authorization and access for playback, and must validate any source changes
before publishing an attachment.

The SDK does not provide remote-video fetching. For printing, a prepared poster
is a static image; the PDF does not contain playback controls or embedded media.
