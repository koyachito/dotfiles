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

sudo paru -Sayu openmyocr
sudo pacman -S recoll
	recollindex　めちゃくちゃ時間かかる
	GUIアプリで統合検索できる。マジでどこのファイルに書いてあったかわからんとき
sudo pacman -S pdfgrep
	pdfgrep -Hnr putchar 行番号付き・再帰で検索
sudo pacman -S ripgrep
	rg putchar　デフォルトで再帰検索（テクストのみ。ソースコードとmd）
