#!/usr/bin/env bash

set -euo pipefail

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 22
sudo ufw allow 1714:1764/tcp
sudo ufw allow 1714:1764/udp

sudo ufw enable
