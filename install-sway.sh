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

ln -sfn "$DOTFILES/config/sway" "$HOME/.config/sway"
ln -sfn "$SCRIPTS/powermenu-sway" "$HOME/.local/bin/powermenu"

sudo cp "$DOTFILES/othersettings/config-sway.toml" \
	/etc/greetd/config.toml

for cmd in \
	sway \
	swaybg \
	swayidle \
	swaylock
do
	command -v "$cmd"
done

# greetd が稼働中なら restart はセッションを巻き込むため行わない。
# 新しい設定は次回の greetd 起動（再起動）時に反映される。
if systemctl is-active --quiet greetd; then
	echo "greetd is running: new config will take effect after reboot."
else
	sudo systemctl enable --now greetd
fi

echo "Sway installation completed."
