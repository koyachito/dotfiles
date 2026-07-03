#!/usr/bin/env bash

set -euo pipefail

NVIM_DIR="nvim-linux-x86_64"
ARCHIVE="${NVIM_DIR}.tar.gz"

cd /tmp

wget -q --show-progress \
"https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/${ARCHIVE}"

sudo rm -rf /opt/nvim

tar -xf "$ARCHIVE"

sudo mv "$NVIM_DIR" /opt/nvim

rm -f "$ARCHIVE"

grep -qxF 'export PATH="/opt/nvim/bin:$PATH"' ~/.profile ||
echo 'export PATH="/opt/nvim/bin:$PATH"' >> ~/.profile
