#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

mkdir -p "$HOME/.config"

configs=(
    sway
    waybar
    kitty
    nvim
    mako
    wlogout
    xremap
    fcitx5
)

for config in "${configs[@]}"; do
    rm -rf "$HOME/.config/$config"
    ln -s "$DOTFILES/config/$config" "$HOME/.config/$config"
    echo "✓ Linked $config"
done
