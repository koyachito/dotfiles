#!/usr/bin/env bash

set -euo pipefail

echo "Installing 42 Tokyo tools..."

# Norminette
pipx install norminette || pipx upgrade norminette

# 42 Header
echo
echo "=================================================="
echo "42 Header"
echo
echo "Install the header plugin using your Neovim plugin manager."
echo
echo "https://github.com/42Paris/42header"
echo "=================================================="
