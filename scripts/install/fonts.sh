#!/usr/bin/env bash
set -euo pipefail

wget -q --show-progress \
"https://github.com/ryanoasis/nerd-fonts/releases/download/v${FONT_VERSION}/JetBrainsMono.zip" \
-O /tmp/JetBrainsMono.zip

rm -rf ~/.local/share/fonts/JetBrainsMono

mkdir -p ~/.local/share/fonts/JetBrainsMono

unzip -oq /tmp/JetBrainsMono.zip \
-d ~/.local/share/fonts/JetBrainsMono

fc-cache -fv

rm -f /tmp/JetBrainsMono.zip
