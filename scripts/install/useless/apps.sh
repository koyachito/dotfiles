#!/usr/bin/env bash
set -euo pipefail

# Firefox (Mozilla official APT)

sudo install -d -m0755 /etc/apt/keyrings

wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- \
| sudo tee /etc/apt/keyrings/packages.mozilla.org.asc >/dev/null

echo \
"deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
| sudo tee /etc/apt/sources.list.d/mozilla.list

# Spotify (official)

curl -fsSL https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg \
| sudo gpg --dearmor -o /etc/apt/keyrings/spotify.gpg

echo \
"deb [signed-by=/etc/apt/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" \
| sudo tee /etc/apt/sources.list.d/spotify.list

# VS Code (Microsoft official)

wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
| gpg --dearmor \
| sudo tee /etc/apt/keyrings/packages.microsoft.gpg >/dev/null

echo \
"deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
| sudo tee /etc/apt/sources.list.d/vscode.list

sudo apt update

sudo apt install -y \
    firefox \
    spotify-client \
    code \
    discord
