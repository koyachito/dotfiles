#!/usr/bin/env bash

set -euo pipefail

if command -v cargo >/dev/null; then
    echo "Rust already installed."
    exit 0
fi

curl https://sh.rustup.rs -sSf | sh -s -- -y

grep -qxF 'source "$HOME/.cargo/env"' ~/.profile ||
echo 'source "$HOME/.cargo/env"' >> ~/.profile

source "$HOME/.cargo/env"
