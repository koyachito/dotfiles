#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"
SCRIPTS="$DOTFILES/scripts"

sudo pacman -S --needed \
	hyprland \
	hypridle \
	hyprlock \
	hyprpaper \
	xdg-desktop-portal-hyprland

ln -sfn "$DOTFILES/config/hypr" "$HOME/.config/hypr"
ln -sfn "$SCRIPTS/powermenu-hypr" "$HOME/.local/bin/powermenu"
ln -sfn "$SCRIPTS/wallpaper-rotate" "$HOME/.local/bin/wallpaper-rotate"

sudo cp "$DOTFILES/othersettings/config-hypr.toml" \
	/etc/greetd/config.toml

for cmd in \
	Hyprland \
	hyprctl \
	hyprlock \
	hypridle \
	hyprpaper
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

systemctl --user daemon-reload
systemctl --user enable wallpaper-rotate.timer

echo "Hyprland installation completed."
