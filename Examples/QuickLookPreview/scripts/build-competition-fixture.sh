#!/bin/bash
set -euo pipefail
example_dir="$(cd "$(dirname "$0")/.." && pwd)"
output_dir="${BUILD_DIR:-$example_dir/.build}"
xcodebuild -project "$example_dir/SiriusMarkdownQuickLookExample.xcodeproj" \
  -scheme CompetitionFixture -configuration Release -derivedDataPath "$output_dir" \
  -destination 'platform=macOS' "CODE_SIGN_IDENTITY=${SIGN_IDENTITY:--}" \
  "CODE_SIGN_STYLE=Manual" build
codesign --verify --deep --strict "$output_dir/Build/Products/Release/CompetitionFixture.app"
printf '%s\n' "$output_dir/Build/Products/Release/CompetitionFixture.app"
