#!/usr/bin/env bash

set -euo pipefail

sudo pacman -S --needed \
	base \
	base-devel \
	bat \
	bitwarden \
	brightnessctl \
	btop \
	btrfs-progs \
	clang \
	cmake \
	eza \
	fcitx5 \
	fcitx5-configtool \
	fcitx5-gtk \
	fcitx5-mozc \
	fd \
	firefox \
	fuzzel \
	fzf \
	git \
	greetd \
	greetd-tuigreet \
	grim \
	jq \
	kdeconnect \
	kitty \
	lazygit \
	less \
	libnotify \
	libinput-tools \
	linux \
	linux-firmware \
	mako \
	neovim \
	networkmanager \
	nodejs \
	noto-fonts-cjk \
	noto-fonts-emoji \
	npm \
	obsidian \
	openssh \
	pacman-contrib \
	pdfgrep \
	pipewire-pulse \
	playerctl \
	python-pipx \
	ripgrep \
	rust \
	shellcheck \
	shfmt \
	slurp \
	sway \
	swaybg \
	swayidle \
	swaylock \
	tesseract-data-jpn \
	thunderbird \
	tldr \
	tree \
	typescript \
	unzip \
	waybar \
	wget \
	wl-clipboard \
	wlsunset \
	xdg-desktop-portal \
	xdg-desktop-portal-wlr \
	yazi \
	zathura \
	zathura-pdf-mupdf \
	zip \
	zoxide

echo "Pacman Install Done."

cargo install --locked xremap zellij

echo "Cargo Install Done."

# --------------------------------------------------------------------
# Paths
# --------------------------------------------------------------------

DOTFILES="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
DOTFILES_CONFIG="$DOTFILES/config"
SETTINGS="$DOTFILES/othersettings"
SCRIPTS="$DOTFILES/scripts"

mkdir -p "$HOME/.local/bin"
mkdir -p "$CONFIG_DIR"

# --------------------------------------------------------------------
# Config symlinks
# --------------------------------------------------------------------

for dir in \
	kitty \
	mako \
	nvim \
	pandoc \
	sway \
	systemd \
	waybar \
	xremap \
	yazi \
	zathura
do
	ln -sfn "$DOTFILES_CONFIG/$dir" "$CONFIG_DIR/$dir"
	echo "Linked: $CONFIG_DIR/$dir -> $DOTFILES_CONFIG/$dir"
done

echo "Symbolic Link Created."

ln -sfn "$SCRIPTS/powermenu" "$HOME/.local/bin/powermenu"

ln -sfn "$SETTINGS/.profile" "$HOME/.profile"
ln -sfn "$SETTINGS/.bashrc" "$HOME/.bashrc"

mkdir -p Pictures/ScreenShots

# --------------------------------------------------------------------
# xremap
# --------------------------------------------------------------------

sudo cp "$SETTINGS/uinput.conf" /etc/modules-load.d/
sudo cp "$SETTINGS/99-uinput.rules" /etc/udev/rules.d/

# inputグループの反映には再ログインが必要
sudo usermod -aG input "$USER"

sudo modprobe uinput
sudo udevadm control --reload-rules
sudo udevadm trigger

# --------------------------------------------------------------------
# greetd
# --------------------------------------------------------------------

sudo cp "$SETTINGS/config.toml" /etc/greetd/

sudo systemctl enable --now greetd
sudo systemctl enable --now NetworkManager

# --------------------------------------------------------------------
# User services
# --------------------------------------------------------------------

systemctl --user daemon-reload
systemctl --user enable --now xremap
systemctl --user enable --now kdeconnect-indicator

# --------------------------------------------------------------------
# Font cache
# --------------------------------------------------------------------

fc-cache -fv

# --------------------------------------------------------------------
# Verify installation
# --------------------------------------------------------------------

for cmd in \
	sway \
	swaybg \
	waybar \
	xremap \
	zellij
do
	command -v "$cmd"
done

echo
echo "Setting Completed."
echo "Please reboot to apply the input group change."
