local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- FPS
config.max_fps = 120

-- Colors
config.color_scheme = "Tokyo Night"

-- Font
config.font_size = 20
config.font = wezterm.font_with_fallback({ "JetBrains Mono", "MesloLGS NF" })
config.default_cursor_style = "SteadyUnderline"

-- Disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- Window
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

-- Tab Bar
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Enable writing {} and [] using norwegian keyboards
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- Keys
config.keys = {
	-- Cmd + Left to move to the beginning of the line
	{
		key = "LeftArrow",
		mods = "CMD",
		action = wezterm.action.SendKey({ key = "Home" }),
	},
	-- Cmd + Right to move to the end of the line
	{
		key = "RightArrow",
		mods = "CMD",
		action = wezterm.action.SendKey({ key = "End" }),
	},
}

-- Remove padding when nvim is running
local padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0.5cell",
}

wezterm.on("update-status", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local title = pane:get_title()
	if string.find(title, "^n-vi-m-") or title == "n" or title == "nvim" then
		overrides.window_padding = {
			left = 0,
			right = 0,
			top = padding.top,
			bottom = 0,
		}
	else
		overrides.window_padding = padding
	end
	window:set_config_overrides(overrides)
end)

return config
