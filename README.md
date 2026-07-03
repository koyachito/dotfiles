# dotfiles

Personal Linux development environment for **Ubuntu 24.04 + Sway**.

## Features

* One-command environment setup
* Sway (Wayland compositor)
* Waybar
* Kitty
* Neovim (GitHub release)
* JetBrainsMono Nerd Font (installed automatically)
* Fuzzel
* Mako
* Wlogout
* Swaylock + Swayidle
* Yazi
* Zellij
* Battery warning (systemd user timer)
* Optional development, applications, and 42 Tokyo setup

---

## Requirements

* Ubuntu 24.04
* Git
* sudo

---

## Installation

Clone the repository.

```bash
git clone https://github.com/koyachito/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
```

### Base desktop

Installs the default desktop environment.

```bash
./install.sh
```

Installs:

* Base packages
* JetBrainsMono Nerd Font
* Sway desktop environment
* Neovim
* Dotfiles configuration

---

### Development environment

```bash
./install.sh --dev
```

Additionally installs:

* Rust (rustup)
* Development tools
* Cargo packages
* Global npm packages

---

### Full environment

```bash
./install.sh --full
```

Additionally installs:

* Firefox (Mozilla official repository)
* Spotify (Spotify official repository)
* Visual Studio Code (Microsoft official repository)
* Discord

---

### 42 Tokyo

```bash
./install.sh --42
```

Additionally installs:

* Norminette

The 42 Header plugin is managed through Lazy.nvim.

Add the plugin to your Neovim configuration, then run:

```vim
:Lazy sync
```

---

### Extras

Machine-specific utilities.

```bash
./install.sh --extras
```

Installs:

* Drawing
* xremap

---

## After Installation

Reload your shell.

```bash
source ~/.profile
```

Restart Sway (or log out and back in).

Open Neovim and install plugins.

```vim
:Lazy sync
```

---

## Repository Layout

```text
.
├── config
│   ├── fuzzel
│   ├── kitty
│   ├── mako
│   ├── nvim
│   ├── sway
│   ├── systemd
│   ├── waybar
│   ├── wlogout
│   └── yazi
├── scripts
│   ├── battery-warning
│   ├── kde-send
│   └── install
│       ├── base.sh
│       ├── fonts.sh
│       ├── desktop.sh
│       ├── neovim.sh
│       ├── rust.sh
│       ├── dev.sh
│       ├── cargo.sh
│       ├── npm.sh
│       ├── apps.sh
│       ├── extras.sh
│       └── 42.sh
├── install.sh
└── README.md
```

---

## Troubleshooting

### Waybar icons appear as squares

This configuration uses **JetBrainsMono Nerd Font**.

Refresh the font cache:

```bash
fc-cache -fv
```

Then restart Sway.

---

### Japanese input does not work

This configuration uses:

* fcitx5
* fcitx5-mozc

If Japanese input is unavailable:

1. Start `fcitx5`.
2. Open `fcitx5-configtool`.
3. Add **Mozc** as an input method.
4. Restart your desktop session.

---

### Neovim clipboard does not work

Clipboard support requires:

```bash
wl-copy --version
```

If the command is missing:

```bash
sudo apt install wl-clipboard
```

---

### Neovim duplicates Enter or Backspace

The official Linux binaries newer than **Neovim v0.11.4** caused duplicated Enter and Backspace input on my Ubuntu 24.04 + Sway environment, even with:

```bash
nvim --clean
```

For that reason this repository installs **Neovim v0.11.4**.

---

### 42 Header

This repository does **not** install the 42 Header automatically.

The plugin is managed through Lazy.nvim.

Create:

```text
~/.config/nvim/lua/plugins/42header.lua
```

with the following contents:

```lua
return {
    {
        "Diogo-ss/42-header.nvim",
        cmd = { "Stdheader" },
        keys = {
            { "<F1>", "<cmd>Stdheader<CR>", desc = "Insert 42 Header" },
        },
        opts = {
            default_map = true,
            auto_update = true,
            user = "your_login",
            mail = "your_email@student.42.fr",
        },
    },
}
```

Then install the plugin:

```vim
:Lazy sync
```

Restart Neovim or run:

```vim
:Lazy reload 42-header.nvim
```

Press **F1** (or run `:Stdheader`) to insert or update the header.

---

### Idle behavior

Default configuration:

* Lock after 15 minutes
* Suspend after 30 minutes
* Lock before every suspend
* Unlock required after resume

