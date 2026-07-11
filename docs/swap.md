# Btrfs + SnapperでSwapファイルを作成する（Arch Linux）

## なぜ専用サブボリュームを作るのか

Btrfsでは、**使用中のSwapファイルを含むサブボリュームはスナップショットを作成できない**。

そのため、

```
@
@home
@snapshots
@swap
```

のように **Swap専用サブボリューム** を作成して管理する。

これにより、

- Snapper
- snap-pac（pacman更新時の自動スナップショット）
- Timeline Snapshot

が正常に動作する。

---

# 手順

## 1. Top Level(SubvolID=5)をマウント

```bash
sudo mkdir -p /mnt/btrfs-top
sudo mount -o subvolid=5 /dev/sdb2 /mnt/btrfs-top
```

確認

```bash
ls /mnt/btrfs-top
```

例

```
@
@home
@snapshots
```

---

## 2. @swapサブボリュームを作成

```bash
sudo btrfs subvolume create /mnt/btrfs-top/@swap
```

確認

```bash
sudo btrfs subvolume list /mnt/btrfs-top
```

以下のようになればOK。

```
top level 5 path @swap
```

---

## 3. Top Levelをアンマウント

```bash
sudo umount /mnt/btrfs-top
```

---

## 4. マウントポイント作成

```bash
sudo mkdir /swap
```

---

## 5. /etc/fstabへ追加

ルートと同じUUIDを使用する。

```fstab
UUID=<BTRFS_UUID> /swap btrfs rw,relatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=/@swap 0 0
```

設定反映

```bash
sudo systemctl daemon-reload
sudo mount -a
```

確認

```bash
findmnt /swap
```

```
TARGET SOURCE
/swap /dev/sdXN[/@swap]
```

---

## 6. Swapファイル作成

Btrfsでは `btrfs filesystem mkswapfile` を使用する。

```bash
sudo btrfs filesystem mkswapfile --size 8g /swap/swapfile
```

---

## 7. Swapを有効化

```bash
sudo swapon /swap/swapfile
```

確認

```bash
swapon --show
free -h
```

---

## 8. 自動有効化

`/etc/fstab`へ追加

```fstab
/swap/swapfile none swap defaults 0 0
```

---

## 9. 動作確認

```bash
swapon --show
```

---

# Snapper確認

手動

```bash
sudo snapper create --description test
```

Timeline

```bash
sudo systemctl start snapper-timeline.service
```

一覧確認

```bash
sudo snapper list
```

pacman更新

```bash
sudo pacman -Syu
```

以下のように表示されれば正常。

```
Performing snapper pre snapshots...
==> root: 72

Performing snapper post snapshots...
==> root: 73
```

---

# トラブルシューティング

## Text file busy

```
ERROR: Could not create subvolume: Text file busy
```

原因

```
/swapfile
```

がルートサブボリューム（`@`）にある。

使用中のSwapファイルを含むサブボリュームはBtrfsの仕様上スナップショットを作成できない。

解決方法

Swap専用サブボリューム（`@swap`）を作成し、

```
/swap/swapfile
```

へ移動する。

---

# 補足

Swap停止

```bash
sudo swapoff /swap/swapfile
```

Swap開始

```bash
sudo swapon /swap/swapfile
```

確認

```bash
swapon --show
```
