#!/usr/bin/env bash

set -euo pipefail

sudo pacman --needed -Sy \
    kitty \
    sway \
    swaylock \
    swayidle \
    waybar \
    mako \
    fuzzel \
    wlogout \
    brightnessctl \
    grim \
    slurp \
    playerctl \
    wl-clipboard \
    fcitx5 \
    fcitx5-mozc \
    fcitx5-configtool \
    libnotify

mkdir -p \
    ~/.config \
    ~/.config/systemd/user \
    ~/.local/bin

for dir in \
    sway \
    waybar \
    kitty \
    mako \
    fuzzel \
    wlogout \
    nvim \
    yazi
do
    ln -sfn \
        "$DOTFILES/config/$dir" \
        "$HOME/.config/$dir"
done

ln -sfn \
    "$DOTFILES/config/systemd/user/battery-warning.service" \
    ~/.config/systemd/user/battery-warning.service

ln -sfn \
    "$DOTFILES/config/systemd/user/battery-warning.timer" \
    ~/.config/systemd/user/battery-warning.timer

ln -sfn \
    "$DOTFILES/scripts/battery-warning" \
    ~/.local/bin/battery-warning

ln -sfn \
    "$DOTFILES/scripts/kde-send" \
    ~/.local/bin/kde-send

systemctl --user daemon-reload
systemctl --user enable --now battery-warning.timer
