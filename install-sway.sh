#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"
SCRIPTS="$DOTFILES/scripts"

sudo pacman -S --needed \
	sway \
	swaybg \
	swayidle \
	swaylock \
	xdg-desktop-portal-wlr

DOTFILES="$HOME/dotfiles"

ln -sfn "$DOTFILES/config/sway" "$HOME/.config/sway"
ln -sfn "$SCRIPTS/powermenu-sway" "$HOME/.local/bin/powermenu"

sudo cp "$DOTFILES/othersettings/config-sway.toml" \
	/etc/greetd/config.toml

for cmd in \
	sway \
	swaybg \
	swayidle \
	swaylock \
	wlsunset
do
	command -v "$cmd"
done

sudo systemctl restart greetd

echo "Sway installation completed."
