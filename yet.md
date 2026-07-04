Discord
Timeshift
VLC
vlc-plugins-all
btop
lazygit

sudo nvim /etc/pachman.conf -> [multilib]の行のコメントアウトを消す
sudo pacman -Sy Steam
(multilibリポジトリを追加・有効化したので、-yオプションで最新データベース取得）
-S: ローカルのデータベース使う
-Sy: サーバーから最新のデータベース取得->インストール
-Syu: データベース更新&システム全体も更新

sudo pacman -S zathura zathura-pdf-mupdf
-> 30
sudo pacman -S tesseract-data-jpn tesseract-data-spa
