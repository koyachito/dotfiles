# dotfiles

![Lint](https://github.com/koyachito/dotfiles/actions/workflows/lint.yml/badge.svg)
![Verify packages](https://github.com/koyachito/dotfiles/actions/workflows/verify-packages.yml/badge.svg)

## Desktop

![Desktop](assets/desktop.png)

## Fastfetch

![Fastfetch](assets/fastfetch.png)

## Resource Usage

![btop](assets/btop.png)

Arch Linux + Sway をベースに構築した、再現性と保守性を重視した開発環境です。

このリポジトリでは、設定ファイルだけでなく、環境構築スクリプトやシステム設定も Git で管理しています。

目標は「OSを再インストールしても短時間で同じ環境を復元できること」と、「自分が理解・管理できる範囲で Linux を使うこと」です。

設計思想については [Design](docs/design.md) にまとめています。

---

# 特徴

* Arch Linux + Sway による軽量なデスクトップ環境
* Gitで管理された再現可能な開発環境
* キーボード中心のワークフロー
* CLI / TUI を優先したソフトウェア構成
* モジュール化された設定ファイル
* シンボリックリンクによる設定管理
* systemd user service によるユーザーサービス管理
* パッケージ管理を pacman に統一し、AUR 依存を最小限に抑える構成

---

# 含まれる主なソフトウェア

## Desktop

* Sway
* Waybar
* Kitty
* Fuzzel
* Mako

## Development

* Neovim
* Git
* Lazygit
* Rust
* Node.js
* TypeScript
* Clang
* CMake

## CLI / TUI

* bat
* btop
* eza
* fd
* fzf
* jq
* ripgrep
* tree
* yazi
* zoxide

## Documents

* Pandoc
* Zathura
* pdfgrep
* Tesseract (日本語OCR)

## Utilities

* Bitwarden
* Thunderbird
* KDE Connect
* xremap
* brightnessctl

---

# リポジトリ構成

```text
.
├── assets/            # スクリーンショット
├── config/            # 各種設定ファイル
├── docs/              # 設計思想・導入手順ドキュメント
│   ├── design.md      # 設計思想
│   └── snapper.md     # Snapper導入手順
├── othersettings/     # system設定・設定例
├── scripts/           # 補助スクリプト
├── install-all.sh     # 環境構築スクリプト
├── extra.sh           # 任意アプリの追加インストール
└── README.md
```

---

# インストール

リポジトリを取得します。

```bash
git clone https://github.com/koyachito/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

基本環境を構築します。

```bash
./install-all.sh
```

Steam・Discord・Spotify など任意のアプリケーションを追加する場合は、

```bash
./extra.sh
```

を実行してください。

---

# インストール内容

`install-all.sh` は以下を自動で設定します。

* pacman によるパッケージインストール
* Cargo パッケージのインストール
* dotfiles のシンボリックリンク作成
* greetd の設定
* systemd user service の有効化
* xremap の設定
* フォントキャッシュ更新
* インストール確認

---

# 復旧

このリポジトリを利用することで、新しい環境への移行やOS再インストール後の復旧は

1. Arch Linux をインストール
2. このリポジトリを clone
3. `install-all.sh` を実行
4. 再起動

という流れで行えます。

---

# 設計思想

この環境は、

* 軽量であること
* 理解・管理できること
* キーボード中心で操作できること
* 環境を容易に再現できること

を重視して設計しています。

なぜ Arch Linux を選んだのか、Sway を採用した理由、ソフトウェア選定方針などについては **design.md** を参照してください。

---

# Snapper

Btrfs スナップショットには Snapper を利用しています。

初回導入手順は [snapper.md](docs/snapper.md) にまとめています。


