#!/usr/bin/env python3
"""Create bounded, deterministic stress fixtures outside the checked-in tree."""
import argparse
from pathlib import Path
import struct
import zlib

parser = argparse.ArgumentParser()
parser.add_argument('directory', type=Path)
args = parser.parse_args()
args.directory.mkdir(parents=True, exist_ok=True)
base = (Path(__file__).parent.parent / 'Fixtures/Formatting.md').read_text()
(args.directory / 'Formatting.md').write_text(base)
(args.directory / 'Capabilities.md').write_text(
    (Path(__file__).parent.parent / 'Fixtures/Capabilities.md').read_text())
for count in (100, 1000, 10000):
    with (args.directory / f'Long-{count}.md').open('w') as f:
        f.write('# Long Markdown stress fixture\n\n')
        for i in range(count):
            f.write(f'## Section {i}\n\nParagraph **{i}**: Unicode 日本語 مرحبا 🌙 and `code`. ' + 'Prepared native text. ' * 8 + '\n\n- [x] Task\n- [ ] Pending\n\n')
(args.directory / 'Malformed.md').write_text('# Incomplete input\n\n**unclosed _emphasis\n\n```swift\nlet x = [\n')
(args.directory / 'Unsupported.md').write_bytes(b'\xff\xfe\x00\xd8')
(args.directory / 'UTF16.md').write_bytes('# UTF-16 document\n\nReadable text.'.encode('utf-16'))
(args.directory / 'Empty.md').write_bytes(b'')
(args.directory / 'Huge.md').write_bytes(b'x' * (17 * 1024 * 1024))
# A recognizable green 64x64 PNG with no external library dependency.
def chunk(kind, data):
    return struct.pack('>I', len(data)) + kind + data + struct.pack('>I', zlib.crc32(kind + data))
raw = b''.join(b'\0' + bytes((20, 180, 100)) * 64 for _ in range(64))
png = b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', 64, 64, 8, 2, 0, 0, 0)) + chunk(b'IDAT', zlib.compress(raw)) + chunk(b'IEND', b'')
(args.directory / 'local-image.png').write_bytes(png)
for path in sorted(args.directory.iterdir()):
    print(f'{path.stat().st_size:10d} {path}')
