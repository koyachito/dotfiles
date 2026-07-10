# BtrfsでSwapファイルを作成する（Arch Linux）

## 1. 8GBのSwapファイルを作成

```bash
sudo btrfs filesystem mkswapfile --size 8g /swapfile
```

このコマンドで、Btrfs用に適切な設定（CoW無効化など）が行われたSwapファイルが作成される。

---

## 2. Swapを有効化

```bash
sudo swapon /swapfile
```

---

## 3. 動作確認

```bash
swapon --show
free -h
```

`Swap` が約8GiBと表示されれば成功。

---

## 4. 再起動後も自動で有効化する

`/etc/fstab` に以下の1行を追加する。

```fstab
/swapfile none swap defaults 0 0
```

例:

```bash
sudo nvim /etc/fstab
```

または

```bash
sudo nano /etc/fstab
```

---

## 5. 再起動後の確認

```bash
swapon --show
```

Swapファイルが表示されれば設定完了。

---

## 補足

### Swapが有効か確認

```bash
swapon --show
```

### Swapを一時的に無効化

```bash
sudo swapoff /swapfile
```

### Swapを再度有効化

```bash
sudo swapon /swapfile
```

