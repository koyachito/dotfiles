sudo pacman -S waydroid
sudo waydroid init -s GAPPS
sudo ufw allow in on waydroid0
sudo ufw allow out on waydroid0
sudo ufw route allow in on waydroid0 out on wlp1s0
sudo ufw route allow in on wlp1s0 out on waydroid0
sudo systemctl enable --now waydroid-container
waydroid session start
waydroid show-full-ui

