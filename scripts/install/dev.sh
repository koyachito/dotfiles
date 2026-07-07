#!/usr/bin/env bash

set -euo pipefail

sudo pacman --needed -Sy \
    clang \
    gdb \
    cmake \
    python3 \
    nodejs \
    npm \
    fzf \
    tree \
    jq \
    shellcheck \
    shfmt \
    cargo
