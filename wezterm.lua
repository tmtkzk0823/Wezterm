---@type Wezterm
local wezterm = require("wezterm")

-- ここに設定内容を記述していく
local config = wezterm.config_builder()

-- 設定ファイルの変更を自動で読み込む
config.automatically_reload_config = true

-- macSKK向け: Control-jで改行されないようにする設定 skk入れたら有効にする
-- https://github.com/mtgto/macSKK?tab=readme-ov-file#q-wezterm-%E3%81%A7-c-j-%E3%82%92%E6%8A%BC%E3%81%99%E3%81%A8%E6%94%B9%E8%A1%8C%E3%81%95%E3%82%8C%E3%81%A6%E3%81%97%E3%81%BE%E3%81%84%E3%81%BE%E3%81%99
---@diagnostic disable-next-line: assign-type-mismatch
---config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

-- font
config.font_size = 13.0
config.font = wezterm.font("HackGen Console NF")

-- 背景の透過度とぼかし
config.window_background_opacity = 0.8
config.macos_window_background_blur = 13

-- QuickSelect patterns (SUPER + Space)
config.quick_select_patterns = {
	-- AWS ARN
	"\\barn:[\\w\\-]+:[\\w\\-]+:[\\w\\-]*:[0-9]*:[\\w\\-/:]+",
}

-- タブバーの表示設定
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- タブバーの色設定
config.colors = {
	tab_bar = {
		background = "#1a1b26",
		active_tab = {
			bg_color = "#7aa2f7",
			fg_color = "#1a1b26",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#414868",
			fg_color = "#c0caf5",
		},
		inactive_tab_hover = {
			bg_color = "#565f89",
			fg_color = "#c0caf5",
		},
		new_tab = {
			bg_color = "#1a1b26",
			fg_color = "#c0caf5",
		},
		new_tab_hover = {
			bg_color = "#414868",
			fg_color = "#c0caf5",
		},
	},
}

-- タブのタイトル表示をカスタマイズ
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local tab_module = require("tab")
	local title = tab_module.custom_title[tab.tab_id] or tab.active_pane.title
	-- タイトルが長すぎる場合は切り詰める
	if #title > 25 then
		title = wezterm.truncate_right(title, 25)
	end
	return " " .. title .. " "
end)

require("keybinds").apply_to_config(config)

-- オプショナルモジュール（keymapsの後に読み込む）
-- require("modules.opacity").apply_to_config(config)

return config
