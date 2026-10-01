#!/bin/bash
# Build a real app + embedded appex. No installation/registration is performed.
set -euo pipefail
example_dir="$(cd "$(dirname "$0")/.." && pwd)"
output_dir="${BUILD_DIR:-$example_dir/.build}"
identity="${SIGN_IDENTITY:--}"
args=()
if [[ -n "${DEVELOPMENT_TEAM:-}" ]]; then args+=("DEVELOPMENT_TEAM=$DEVELOPMENT_TEAM"); fi
# Command-line settings also apply to package dependency targets. Both Swift and
# C/ObjC dependencies are checked for extension-unavailable API references.
xcodebuild -project "$example_dir/SiriusMarkdownQuickLookExample.xcodeproj" \
  -scheme SiriusMarkdownPreview -configuration Release -derivedDataPath "$output_dir" \
  -destination 'platform=macOS' \
  "CODE_SIGN_IDENTITY=$identity" "CODE_SIGN_STYLE=Manual" \
  'OTHER_SWIFT_FLAGS=$(inherited) -application-extension' \
  'OTHER_CFLAGS=$(inherited) -fapplication-extension' \
  ${args[@]+"${args[@]}"} build
app="$output_dir/Build/Products/Release/SiriusMarkdownPreview.app"
codesign --verify --deep --strict --verbose=2 "$app"
printf '%s\n' "$app"
