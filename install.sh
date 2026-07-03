#!/usr/bin/env bash

set -euo pipefail

export DOTFILES="$HOME/dotfiles"
export FONT_VERSION="3.4.0"
export NEOVIM_VERSION="v0.11.4"

run() {
    echo
    echo "==> ${1%.sh}"
    bash "$DOTFILES/scripts/install/$1"
}

usage() {
    cat <<EOF
Usage:
  ./install.sh
  ./install.sh --dev
  ./install.sh --full
  ./install.sh --42
  ./install.sh --extras
EOF
}

default_install() {
    run base.sh
    run fonts.sh
    run desktop.sh
    run neovim.sh
}

case "${1:-}" in
    "")
        default_install
        ;;
    --dev)
        default_install
        run rust.sh
        run dev.sh
        run cargo.sh
        run npm.sh
        ;;
    --full)
        default_install
        run rust.sh
        run dev.sh
        run cargo.sh
        run npm.sh
        run apps.sh
        ;;
	--42)
        default_install
        run rust.sh
        run dev.sh
        run cargo.sh
        run npm.sh
        run 42.sh
        ;;
    --extras)
        run extras.sh
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage
        exit 1
        ;;
esac

echo
echo "Done!"
echo
echo "Run:"
echo "  source ~/.profile"
echo "Restart Sway."
