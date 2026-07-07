ln -s ~/dotfiles/updall ~/.local/bin

| 管理方法       | パッケージ                                                          |
| ---------- | -------------------------------------------------------------- |
| **pacman** | zellij, node, npm, typescript, yarn, node-gyp, semver, nopt, grunt-cli |
| **cargo**  | xremap, cargo-install-update                           |
| **pipx**   | norminette                                                     |

sudo pacman -S pacman-contrib

Discord
Timeshift
VLC
vlc-plugins-all
btop
lazygit
kdeconnect
pandoc & typst
	ln -s ~/dotfiles/config/pandoc ~/.local/share
zoxide
	たぶんfzfも自動で入る
tldr
eza
dust(いらんかも)

sudo nvim /etc/pachman.conf -> [multilib]の行のコメントアウトを消す
sudo pacman -Sy Steam
(multilibリポジトリを追加・有効化したので、-yオプションで最新データベース取得）
-S: ローカルのデータベース使う
-Sy: サーバーから最新のデータベース取得->インストール
-Syu: データベース更新&システム全体も更新

sudo pacman -S zathura zathura-pdf-mupdf
-> 30
sudo pacman -S tesseract-data-jpn tesseract-data-spa
-> yaziのconfigいじる。すでにpush済みなので入れたら動くよ
./zathurarcにいろいろ追加

brightnessctl

sudo pacman -Fy pdftoppm
for ((i=1; i <= 8; i++)); do
	mv c0$i.en.pdf ./done/
doneudo pacman -S poppler

sudo pacman -S recoll
	recollindex　めちゃくちゃ時間かかる
	GUIアプリで統合検索できる。マジでどこのファイルに書いてあったかわからんとき
	recollq putchar　CLIでも使える
sudo pacman -S pdfgrep
	pdfgrep -Hnr putchar 行番号付き・再帰で検索
sudo pacman -S ripgrep
	rg putchar　デフォルトで再帰検索（テクストのみ。ソースコードとmd）

sudo pacman -S fd
	zathura "$(fd '\.pdf$' | fzf)"とかで便利。findの便利版

cargo install cargo-update

sudo pacman -S typescript
	npmで入れないで、pacman管理に移行

sudo pacman -S zellij
	cargoからpacmanに移行

以下、正直クラウドがあるから必要はない
sudo pacman -S flatpak
sudo flatpak remote-add --if-not-exists flathub \
https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub org.onlyoffice.desktopeditors
flatpak run org.onlyoffice.desktopeditors

