#!/usr/bin/env bash

set -euo pipefail

source "$HOME/.cargo/env"

cargo install zellij

cargo install yazi-fm \
    --locked
