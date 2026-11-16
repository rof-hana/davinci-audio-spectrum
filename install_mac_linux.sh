#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS_NAME="$(uname -s)"

if [[ "$OS_NAME" == "Darwin" ]]; then
    RESOLVE_FUSION_DIR="$HOME/Library/Application Support/Blackmagic Design/DaVinci Resolve/Fusion"
elif [[ "$OS_NAME" == "Linux" ]]; then
    RESOLVE_FUSION_DIR="$HOME/.local/share/DaVinciResolve/Fusion"
else
    echo "Unsupported OS: $OS_NAME (use install_windows.bat on Windows)" >&2
    exit 1
fi

FUSES_DIR="$RESOLVE_FUSION_DIR/Fuses"
EFFECTS_DIR="$RESOLVE_FUSION_DIR/Templates/Edit/Effects"
GENERATORS_DIR="$RESOLVE_FUSION_DIR/Templates/Edit/Generators"

mkdir -p "$FUSES_DIR" "$EFFECTS_DIR" "$GENERATORS_DIR"

cp -f "$SCRIPT_DIR/AudioSpectrumAnalyzer.fuse" "$FUSES_DIR/"
cp -f "$SCRIPT_DIR/drfx_src/Edit/Effects/Audio Spectrum Analyzer.setting" "$EFFECTS_DIR/"
cp -f "$SCRIPT_DIR/drfx_src/Edit/Generators/Audio Spectrum Analyzer.setting" "$GENERATORS_DIR/"

echo "Installed AudioSpectrumAnalyzer successfully:"
echo "  Fuse:      $FUSES_DIR/AudioSpectrumAnalyzer.fuse"
echo "  Effect:    $EFFECTS_DIR/Audio Spectrum Analyzer.setting"
echo "  Generator: $GENERATORS_DIR/Audio Spectrum Analyzer.setting"
echo ""
echo "Please restart DaVinci Resolve if it is currently running."
