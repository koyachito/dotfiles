#!/usr/bin/env bash
set -euo pipefail

#sudo apt update

sudo pacman --needed -Sy \
    git \
    curl \
    wget \
    unzip \
    zip \
    pkg-config \
    ca-certificates \
    gnupg
