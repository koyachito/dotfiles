#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
DOTFILES_CONFIG="$DOTFILES/config"
SETTINGS="$DOTFILES/othersettings"
SCRIPTS="$DOTFILES/scripts"

sudo pacman -S --needed \
	hyprland \
	hypridle \
	hyprlock \
	xdg-desktop-portal-hyprland

DOTFILES="$HOME/dotfiles"

ln -sfn "$DOTFILES/config/hypr" "$HOME/.config/hypr"
ln -sfn "$DOTFILES/config/waybar-hypr" "$HOME/.config/waybar"
ln -sfn "$SCRIPTS/powermenu-hypr" "$HOME/.local/bin/powermenu"

sudo cp "$DOTFILES/othersettings/config-hypr.toml" \
	/etc/greetd/config.toml

systemctl --user restart xdg-desktop-portal.service

for cmd in \
	Hyprland \
	hyprctl \
	hyprlock \
	hypridle
do
	command -v "$cmd"
done

echo "Hyprland installation completed."
