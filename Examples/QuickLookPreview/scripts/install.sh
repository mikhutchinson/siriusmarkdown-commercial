#!/bin/bash
# Explicit local developer install; preserves any pre-existing app by refusing it.
set -euo pipefail
example_dir="$(cd "$(dirname "$0")/.." && pwd)"
source_app="${1:-$example_dir/.build/Build/Products/Release/SiriusMarkdownPreview.app}"
install_root="${INSTALL_ROOT:-$HOME/Applications}"
installed_app="$install_root/SiriusMarkdownPreview.app"
[[ -d "$source_app/Contents/PlugIns/MarkdownPreviewExtension.appex" ]] || { echo 'Build the app first.' >&2; exit 1; }
[[ ! -e "$installed_app" ]] || { echo "Refusing to overwrite: $installed_app" >&2; exit 1; }
codesign --verify --deep --strict "$source_app"
mkdir -p "$install_root"
ditto "$source_app" "$installed_app"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$installed_app"
open "$installed_app"
printf '\nInstalled: %s\nEnable SiriusMarkdown in System Settings > General > Login Items & Extensions > Quick Look.\n' "$installed_app"
pluginkit -m -A -D -i dev.swiftpython.SiriusMarkdownPreview.PreviewExtension
