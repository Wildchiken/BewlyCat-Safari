#!/bin/bash
# ============================================================
# BewlyCat Safari Extension Packaging Script
# ============================================================
# This script builds the web extension for Safari and, if Xcode
# is available, converts it into a Safari native app wrapper.
#
# Prerequisites:
#   - Xcode 15+ (from Mac App Store, NOT just Command Line Tools)
#   - pnpm
#
# Usage:
#   ./scripts/safari-package.sh              # Build & convert
#   ./scripts/safari-package.sh --build-only  # Build only, no Xcode project
#   ./scripts/safari-package.sh --help        # Show help
# ============================================================

set -euo pipefail

BUILD_ONLY=false
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
EXTENSION_DIR="$PROJECT_DIR/extension-safari"
XCODE_PROJECT_DIR="$PROJECT_DIR/extension-safari-macos"

help() {
  sed -n 's/^# //p; s/^#$//p' "$0"
  exit 0
}

for arg in "$@"; do
  case "$arg" in
    --help|-h) help ;;
    --build-only) BUILD_ONLY=true ;;
    *) echo "Unknown option: $arg"; help ;;
  esac
done

echo "🏗️  Building BewlyCat for Safari…"
cd "$PROJECT_DIR"

# Step 1: Build the web extension
echo ""
echo "📦 Step 1: Building extension-safari/"
pnpm run build-safari

if $BUILD_ONLY; then
  echo ""
  echo "✅ Build complete! Output: extension-safari/"
  echo "   Skip Xcode conversion (--build-only)"
  echo ""
  echo "   To create the Safari app manually later:"
  echo "   xcrun safari-web-extension-converter $EXTENSION_DIR \\"
  echo "     --project-location $XCODE_PROJECT_DIR \\"
  echo "     --macos-only"
  exit 0
fi

# Step 2: Check for Xcode
echo ""
echo "🍎 Step 2: Checking for Xcode…"

XCODE_PATH=$(mdfind "kMDItemKind == 'Application'" 2>/dev/null | grep -i "Xcode.app" | head -1)
if [ -z "$XCODE_PATH" ]; then
  XCODE_PATH="/Applications/Xcode.app"
fi

if [ ! -d "$XCODE_PATH" ]; then
  echo "❌ Xcode not found."
  echo ""
  echo "   Safari extensions require Xcode (not just Command Line Tools)."
  echo "   Install Xcode from the Mac App Store, then run:"
  echo ""
  echo "   xcode-select --switch /Applications/Xcode.app"
  echo ""
  echo "   Then re-run this script."
  echo ""
  echo "   Or to just build the web extension part (for manual processing):"
  echo "   ./scripts/safari-package.sh --build-only"
  exit 1
fi

# Verify the converter tool is present
CONVERTER="$XCODE_PATH/Contents/Developer/Tools/safari-web-extension-converter"
if [ ! -f "$CONVERTER" ]; then
  echo "❌ safari-web-extension-converter not found inside Xcode."
  echo "   This tool requires Xcode 15+."
  exit 1
fi

echo "✅ Xcode found at: $XCODE_PATH"

# Step 3: Convert to Safari native app
echo ""
echo "📱 Step 3: Creating Safari Xcode project…"
echo "   Output: $XCODE_PROJECT_DIR"

"$CONVERTER" "$EXTENSION_DIR" \
  --project-location "$XCODE_PROJECT_DIR" \
  --macos-only \
  --no-prompt

echo ""
echo "✅ Safari extension Xcode project created!"
echo ""
echo "   Next steps:"
echo "   1. Open $XCODE_PROJECT_DIR in Xcode"
echo "   2. Set your Team ID in Signing & Capabilities"
echo "   3. Build and run the app"
echo "   4. Enable the extension in Safari → Settings → Extensions"