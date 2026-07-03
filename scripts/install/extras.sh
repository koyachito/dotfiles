#!/usr/bin/env bash
set -euo pipefail

sudo apt install -y drawing

if command -v cargo >/dev/null; then
    cargo install xremap --features gnome
else
    echo "cargo not found."
    echo "Run ./install.sh --dev first."
fi
