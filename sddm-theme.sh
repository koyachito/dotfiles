#!/usr/bin/env bash

set -euo pipefail

git clone -b master --depth 1 https://github.com/Keyitdev/sddm-astronaut-theme.git
cd sddm-astronaut-theme
./setup.sh
