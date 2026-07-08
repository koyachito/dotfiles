# Snapper Setup (Btrfs + systemd-boot)

> **前提**
>
> * Arch Linux
> * Btrfs (`@`、`@home` サブボリューム構成)
> * systemd-boot
> * 新規インストール後の初期セットアップ

---

## 1. Btrfs のトップレベルをマウント

```bash
sudo mkdir -p /mnt/btrfs-top

sudo mount -o subvolid=5 \
    "$(findmnt -no SOURCE / | sed 's/\[.*\]//')" \
    /mnt/btrfs-top
```

確認

```bash
sudo btrfs subvolume list /mnt/btrfs-top
```

---

## 2. `@snapshots` サブボリュームを作成

```bash
sudo btrfs subvolume create /mnt/btrfs-top/@snapshots
```

確認

```bash
sudo btrfs subvolume list /mnt/btrfs-top
```

`@snapshots` が表示されればOK。

---

## 3. トップレベルをアンマウント

```bash
sudo umount /mnt/btrfs-top

sudo rmdir /mnt/btrfs-top
```

---

## 4. マウントポイントを作成

```bash
sudo mkdir /.snapshots
```

---

## 5. Btrfs UUID を確認

```bash
findmnt -no UUID /
```

例

```text
f7f214c4-0ccc-42a8-a347-7308485a7142
```

---

## 6. `/etc/fstab` に追加

```bash
sudo nvim /etc/fstab
```

以下を追加する。

```fstab
UUID=<YOUR_UUID> /.snapshots btrfs rw,relatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=/@snapshots 0 0
```

`<YOUR_UUID>` は手順5で確認したUUIDに置き換える。

---

## 7. マウント

```bash
sudo mount -a
```

確認

```bash
findmnt /.snapshots
```

期待される出力例

```text
TARGET        SOURCE
/.snapshots   /dev/sdXN[/@snapshots]
```

---

## 8. Snapper と snap-pac をインストール

```bash
sudo pacman -S snapper snap-pac
```

---

## 9. Snapper 初期設定

一度 `/.snapshots` のマウントを外す。

```bash
sudo umount /.snapshots

sudo rmdir /.snapshots
```

Snapper の設定を作成。

```bash
sudo snapper -c root create-config /
```

Snapper が作成した `.snapshots` サブボリュームを削除。

```bash
sudo btrfs subvolume delete /.snapshots
```

再びマウントポイントを作成。

```bash
sudo mkdir /.snapshots
```

`fstab` に従ってマウント。

```bash
sudo mount -a
```

---

## 10. Snapper タイマーを有効化

```bash
sudo systemctl enable --now snapper-timeline.timer

sudo systemctl enable --now snapper-cleanup.timer
```

---

## 11. 動作確認

設定一覧

```bash
sudo snapper list-configs
```

スナップショット一覧

```bash
sudo snapper list
```

期待される出力例

```text
Config │ Subvolume
root   │ /

# │ Type   │ Description
0 │ single │ current
```

---

## 12. snap-pac の確認

適当なパッケージを再インストールする。

```bash
sudo pacman -S tree
```

終了後

```bash
sudo snapper list
```

以下のような `pre` と `post` が増えていれば成功。

```text
# │ Type │ Pre # │ Description
1 │ pre  │       │ pacman
2 │ post │ 1     │ pacman
```

---

# 完了

これで以下が利用できる。

* Btrfs スナップショット
* Snapper
* snap-pac による pacman 更新前後の自動スナップショット
* Timeline スナップショット
* Cleanup の自動実行

以後は通常どおり更新するだけでよい。

```bash
sudo pacman -Syu
```

