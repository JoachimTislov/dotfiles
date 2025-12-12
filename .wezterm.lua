-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

local pwsh = { "pwsh", "-NoLogo" }
config.max_fps = 120
config.default_prog = pwsh

config.skip_close_confirmation_for_processes_named = {}
config.enable_scroll_bar = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.automatically_reload_config = true
config.window_background_opacity = 0.96
config.background = {
	-- {
	-- 		source = {
	-- 			File = "C:\\Users\\joachim.tislov\\Pictures\\Backgrounds\\technology-futuristic.png",
	-- 		},
	-- },
}

config.keys = {
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "wsl", "-e", "tmux" },
		}),
		default_cwd = "/home/joachim",
	},
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({
			args = pwsh,
		}),
		default_cwd = "C:\\Users\\joachim.tislov\\IdeasProjects",
	},
}

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- or, changing the font size and color scheme.
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16
config.color_scheme = "Batman"

-- Finally, return the configuration to wezterm:
return config
