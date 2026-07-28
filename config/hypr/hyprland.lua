-- ~/.config/hypr/hyprland.lua
-- hyprland.conf (hyprlang) からの移植版。Hyprland 0.55+ の Lua 設定 API を使用。
-- API は hl テーブル配下に生えている: hl.config / hl.bind / hl.window_rule / hl.on など。
--
-- 注意:
--   * .lua と .conf が両方あると .lua が優先される。判定は「起動時のみ」なので
--     切り替えには Hyprland の再起動が必要（hyprctl reload では切り替わらない）。
--   * hypridle / hyprlock / hyprpaper / waybar は今まで通り独自形式のまま。触らなくてよい。

------------------------------------------------------------
-- Variables
------------------------------------------------------------
-- hyprlang の $mainMod = SUPER は Lua のローカル変数になる。
-- 文字列連結は `..` （Lua の演算子）。

local mainMod  = "SUPER"
local terminal = "kitty"
local menu     = "fuzzel"

------------------------------------------------------------
-- Monitor
------------------------------------------------------------
-- monitor = ,preferred,auto,1 と等価。
-- output = "" は「全出力に対するフォールバック」を意味する。

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

------------------------------------------------------------
-- Environment
------------------------------------------------------------
-- hl.env(名前, 値, dbus?) 。第3引数を true にすると
-- systemctl --user import-environment 相当の伝播も行う（旧 envd =）。
-- fcitx5 は Wayland ネイティブなので XMODIFIERS のみ。GTK_IM_MODULE / QT_IM_MODULE は未設定のまま。

hl.env("XCURSOR_SIZE", "24")
hl.env("XMODIFIERS", "@im=fcitx")

------------------------------------------------------------
-- Input
------------------------------------------------------------
-- hyprlang の `input { ... }` セクションは hl.config({ input = { ... } }) に対応。
-- ネストしたブロック（touchpad）はそのままネストしたテーブルになる。

hl.config({
    input = {
        kb_layout    = "us",
        repeat_delay = 300,
        repeat_rate  = 25,
        follow_mouse = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

------------------------------------------------------------
-- Startup (旧 exec-once)
------------------------------------------------------------
-- exec-once に相当するキーワードは廃止。代わりに "hyprland.start" イベントを購読する。
-- config.reloaded は別イベントなので、reload では再実行されない = exec-once と同じ挙動。
-- hl.exec_cmd は sh -c 経由で実行されるので $() や ~ の展開もそのまま効く。

hl.on("hyprland.start", function()
    -- hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar -c ~/.config/waybar/config-hypr -s ~/.config/waybar/style.css")
    hl.exec_cmd("mako")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("wlsunset -T 6500 -t 2800 -l 19.4326 -L -99.1332")
    hl.exec_cmd("systemctl --user start xremap.service")
    hl.exec_cmd("hypridle")

    -- KDE Connect
    -- - Waylandセッションでのみ意味がある（通知・クリップボード共有など）
    -- - DBus Activationで起動するが初回スマホ側からの接続ではプロセスがないのでネットワークの待ち受けが機能しない
    -- - そのためWM依存で常時起動
    hl.exec_cmd("kdeconnectd")
end)

------------------------------------------------------------
-- Misc / Decoration
------------------------------------------------------------
-- hl.config() は何回呼んでもよく、渡したキーだけが上書きされる。
-- 見通し優先で misc と decoration をまとめている。

hl.config({
    misc = {
        disable_hyprland_logo   = false,
        force_default_wallpaper = 2,
    },

    decoration = {
        rounding         = 10,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled = true,
            size    = 6,
            passes  = 2,
        },
    },
})

------------------------------------------------------------
-- Window Rules
------------------------------------------------------------
-- 旧: windowrule { name = ..., match:class = ..., opacity = ... }
-- 新: match テーブル = 条件（props）、それ以外のトップレベル項目 = 効果（effects）。
-- opacity は文字列で "アクティブ [override] 非アクティブ [override]" の形式のまま渡す。

hl.window_rule({
    name  = "kitty-opacity",
    match = { class = "^(kitty)$" },

    opacity = "0.90 override 0.80 override",
})

------------------------------------------------------------
-- Applications
------------------------------------------------------------
-- hl.bind(キー文字列, ディスパッチャ, オプション?)
-- キーは "SUPER + SHIFT + Q" のような1本の文字列。
-- hl.dsp.* は「実行」ではなく「実行内容を表すクロージャ」を返すだけ。

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("kitty -e yazi"))

-- ChatGPT
hl.bind("SUPER + C", hl.dsp.exec_cmd("firefox --new-tab https://chatgpt.com"))

-- Spotify
hl.bind("SUPER + S", hl.dsp.exec_cmd("firefox --new-tab https://open.spotify.com"))

-- GitHub
hl.bind("SUPER + G", hl.dsp.exec_cmd("firefox --new-tab https://github.com"))

hl.bind("SUPER + SHIFT + Y", hl.dsp.exec_cmd("firefox --new-tab https://www.youtube.com/"))

-- [[ ]] は Lua のロング文字列。ダブルクォートをエスケープせずに書ける。
hl.bind("SUPER + O", hl.dsp.exec_cmd([[chromium --app="chrome-extension://ophjlpahpchlmihnnnihgmmeilfjmjjc/index.html"]]))


hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("~/.local/bin/powermenu"))

------------------------------------------------------------
-- Session
------------------------------------------------------------

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))

-- uwsm でセッションを起動している場合は exit ではなく
-- hl.dsp.exec_cmd("uwsm stop") を使うこと（クライアントを巻き込まず順序立てて落とせる）。
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())

------------------------------------------------------------
-- Focus
------------------------------------------------------------
-- movefocus, l → hl.dsp.focus({ direction = "left" })
-- 方向名は l/d/u/r ではなく left/down/up/right の綴りを使う。

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

------------------------------------------------------------
-- Move windows
------------------------------------------------------------
-- movewindow → hl.dsp.window.move({ direction = ... })
-- 同じ window.move が方向・座標・ワークスペース・モニタ移動を兼ねる（渡すキーで分岐）。

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

------------------------------------------------------------
-- Window
------------------------------------------------------------
-- fullscreen（引数なし）は「本物の全画面をトグル」。
-- mode = "maximized" にすると旧 fullscreen, 1 相当。

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))

------------------------------------------------------------
-- Resize (submap)
------------------------------------------------------------
-- hl.define_submap(名前, function() ... end) の中で呼んだ hl.bind だけが
-- そのサブマップ専用になる。binde（押しっぱなしで連射）は { repeating = true }。
-- 抜けるのは hl.dsp.submap("reset")。ハマったら別 TTY から
--   hyprctl dispatch 'hl.dsp.submap("reset")'
-- で戻せる。

hl.define_submap("resize", function()
    hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0 }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10 }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10 }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0 }), { repeating = true })

    hl.bind("Return", hl.dsp.submap("reset"))
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

------------------------------------------------------------
-- Workspaces
------------------------------------------------------------
-- Lua 化の一番のうまみ。20行の bind がループ4行になる。
-- i % 10 で 10 → キー "0" に落ちる。
-- workspace, N        → hl.dsp.focus({ workspace = N })
-- movetoworkspace, N  → hl.dsp.window.move({ workspace = N })

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

------------------------------------------------------------
-- Screenshot
------------------------------------------------------------
-- exec_cmd は sh -c 経由なので $(slurp) や $(date ...) はそのまま動く。
-- Lua 側で $ を解釈しないよう [[ ]] のロング文字列で囲っている。

hl.bind("Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" ~/Pictures/ScreenShots/$(date +'%Y-%m-%d_%H-%M-%S').png]]))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd([[grim ~/Pictures/ScreenShots/$(date +'%Y-%m-%d_%H-%M-%S').png]]))
hl.bind("CTRL + Print", hl.dsp.exec_cmd([[sh -c 'grim -g "$(slurp)" - | wl-copy']]))

------------------------------------------------------------
-- Audio
------------------------------------------------------------
-- 元の .conf にフラグが無かったので挙動を変えないようそのまま移植している。
-- ロック画面中も効かせたい / 押しっぱなしで連続変化させたいなら
-- 第3引数に { locked = true, repeating = true } を足す。

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

------------------------------------------------------------
-- Brightness
------------------------------------------------------------

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
