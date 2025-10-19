-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "nordfox"
config.window_close_confirmation = "NeverPrompt"

config.colors = {
	cursor_bg = "#eeeeee",
	cursor_fg = "black",
	-- background = "#2f343f",
	background = "#303841",
	tab_bar = {
		background = "#333333",
		active_tab = {
			bg_color = "#333333",
			fg_color = "#c0c5ce",
		},
		inactive_tab = {
			bg_color = "#333333",
			fg_color = "#545862",
		},
		inactive_tab_hover = {
			bg_color = "#333333",
			fg_color = "#c0c5ce",
		},
		new_tab = {
			bg_color = "#333333",
			fg_color = "#545862",
		},
	},
}

-- config.font_rules = {
-- 	{
-- 		intensity = "Bold",
-- 		font = wezterm.font({ family = "MesloLGMDZ Nerd Font", weight = "Regular" }),
-- 	},
-- }

config.window_frame = {
	-- font = wezterm.font({ family = "MesloLGMDZ Nerd Font Mono", weight = "Bold" }),
	font = wezterm.font({ family = "MesloLGMDZ Nerd Font Mono", weight = "Bold" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 12.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#333333",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#333333",
}

config.bold_brightens_ansi_colors = false

-- config.freetype_load_target = 'Light'
config.freetype_render_target = "HorizontalLcd"

-- config.font = wezterm.font("MesloLGMDZ Nerd Font Mono")
-- config.font_size = 11.3
-- config.line_height = 0.9

config.font = wezterm.font("Hack Nerd Font")
config.font_size = 11.3
config.line_height = 1.05

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.window_decorations = 'RESIZE'
config.window_padding = {
	left = 3,
	right = 3,
	top = 14,
	bottom = 3,
}

config.ssh_domains = {
	{
		name = "vmware",
		username = "jernejar",
		remote_address = "vmware",
		-- Optional: set this to true if you want to use multiplexing
		multiplexing = "None",
	},
}

config.default_domain = "vmware"
--config.default_prog = { 'pwsh.exe' }
-- config.default_domain = "WSL:Ubuntu"

config.max_fps = 120

-- set to false to disable the tab bar completely
config.enable_tab_bar = false

-- set to true to hide the tab bar when there is only
-- a single tab in the window
-- config.hide_tab_bar_if_only_one_tab = true
--
-- config.tab_bar_at_bottom = true
--
-- config.use_fancy_tab_bar = false

--config.window_background_opacity = 0.6 -- 0.0 is fully transparent, 1.0 is opaque
--config.win32_system_backdrop = 'Acrylic' -- Options: 'Acrylic', 'Mica', 'Tabbed'
--config.text_background_opacity = 0.6   -- optional: controls text cell background
--config.enable_wayland = false

config.keys = {
	-- paste from the clipboard
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	-- paste from the primary selection
	{ key = "v", mods = "CTRL", action = act.PasteFrom("PrimarySelection") },
}

config.mouse_bindings = {
	-- Change the default click behavior so that it populates
	-- the Clipboard rather the PrimarySelection.
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor("Clipboard"),
	},
}

-- and finally, return the configuration to wezterm
return config
