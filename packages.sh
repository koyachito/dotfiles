#!/usr/bin/env bash

set -e

sudo pacman -S --needed \
    sway \
    waybar \
    kitty \
    fuzzel \
    mako \
    swaybg \
    swayidle \
    swaylock \
    wl-clipboard \
    xdg-desktop-portal-wlr \
    xdg-desktop-portal \
    pipewire \
    pipewire-pulse \
    wireplumber \
    networkmanager \
    firefox \
    neovim \
    git \
    curl \
    wget \
    unzip \
    zip \
    fastfetch \
    htop \
    yazi \
    zellij

#!/usr/bin/env bash

sudo systemctl enable NetworkManager
sudo systemctl enable greetd
