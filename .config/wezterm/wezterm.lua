local wezterm = require("wezterm")
local mux = wezterm.mux
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

-- Default workspace
config.default_workspace = "main"

-- Tab Bar
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Enable writing {} and [] using norwegian keyboards
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- Remove padding when nvim is running
local padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0.5cell",
}

-- Apps that should have minimal padding
local minimal_padding_apps = { "^n%-vi%-m%-", "^nvim", "n", "opencode" }

wezterm.on("update-status", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local title = pane:get_title()

	local should_minimize_padding = false
	for _, pattern in ipairs(minimal_padding_apps) do
		if title == pattern or title:match(pattern) then
			should_minimize_padding = true
			break
		end
	end

	if should_minimize_padding then
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

-- Enables closing of tabs with CMD-w without confirmation
config.keys = {
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "o",
		mods = "CTRL",
		action = wezterm.action.SendString("cdi\r"),
	},
}

-- Create permanent tabs on startup
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({
		workspace = "main",
		cwd = wezterm.home_dir .. "/Documents/notes",
	})

	-- Tab 1: Notes
	tab:set_title("notes")
	pane:send_text("nvim .\n")

	-- Tab 2: Opencode
	local tab2, pane2 = window:spawn_tab({
		cwd = wezterm.home_dir,
	})
	tab2:set_title("opencode")
	pane2:send_text("opencode\n")

	-- Tab 3: Shell
	window:spawn_tab({
		cwd = wezterm.home_dir,
	})

	-- Focus back to nvim tab
	tab:activate()
end)

return config
