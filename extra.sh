#!/usr/bin/env bash

# extra.sh - 任意アプリケーションの追加インストール
# 事前条件: /etc/pacman.conf の [multilib] セクションのコメントアウトを解除しておくこと

set -euo pipefail

# multilib が有効か自動チェック（有効でなければエラー終了）
# grep -q: 出力せず終了コードだけ返す
if ! grep -q '^\[multilib\]' /etc/pacman.conf; then
	echo "Error: [multilib] is not enabled in /etc/pacman.conf" >&2
	echo "Uncomment the [multilib] section and its Include line, then re-run." >&2
	exit 1
fi

# -Sy: パッケージデータベースを同期してからインストール
# --needed: インストール済みのパッケージはスキップ
sudo pacman -Sy --needed \
	steam \
	discord \
	vlc \
	xorg-xwayland

echo "Extra apps installed."
