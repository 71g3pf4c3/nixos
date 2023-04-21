local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}
config.unix_domains = {
	{
		name = 'unix',
	},
}
local function hexencode(str)
   return (str:gsub(".", function(char) return string.format("%02x", char:byte()) end))
end
config.default_gui_startup_args = { 'connect', 'unix' }
config.font = wezterm.font("Comic Code Ligatures")
config.font_size = 10.0
config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 1,
}
config.color_scheme = "Gruvbox Light"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.pane_focus_follows_mouse = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }
config.window_background_opacity = 0.94
config.colors = {
	tab_bar = {
		background = '#bdae93',
		active_tab = {
			bg_color = '#ebdbb2',
			fg_color = '#282828',
			intensity = 'Bold',
			underline = 'None',
			italic = true,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = '#bdae93',
			fg_color = '#ebdbb2',
		},
		inactive_tab_hover = {
			bg_color = '#d5c4a1',
			fg_color = '#ebdbb2',
			italic = true,
		},
		new_tab = {
			bg_color = '#bdae93',
			fg_color = '#ebdbb2',
		},
		new_tab_hover = {
			bg_color = '#d5c4a1',
			fg_color = '#ebdbb2',
			italic = true,
		},
	}
}
wezterm.on('update-right-status', function(window, pane)
	local name = window:active_key_table()
	local status = "NORMAL"
	local hostname = " " .. wezterm.hostname() .. " "
	local hex=string.sub(hexencode("nix"),0,6)
	local color = "#a89984"
	if name then
		if name == "resize_mode" then
			status = "RESIZE"
			color = "#d65d0e"
		end
		if name == "window_mode" then
			status = "WINDOW"
			color = "#83a598"
		end
	end
	window:set_right_status(
		wezterm.format({
			{ Foreground = { Color = "#ebdbb2" } },
			{ Background = { Color = "#" .. hex } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = hostname }
		}) ..
		wezterm.format({
			{ Foreground = { Color = "#ebdbb2" } },
			{ Background = { Color = color } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = " " .. status .. " " }
		})
	);
end)
wezterm.on('update-status', function(window, pane)
	domainName = domain:name()
	window:set_left_status(
		wezterm.format({
			{ Foreground = { Color = "#928374" } },
			{ Background = { Color = "#d5c4a1" } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = window:active_workspace() }
		})
	);
end)
config.keys = {
	{
		key = 'b',
		mods = 'CTRL',
		action = act.ActivateKeyTable {
			name = 'window_mode',
			timeout_milliseconds = 300,
			mods = 'ALT',
		},
	},
	{
		key = 'r',
		mods = 'CTRL|SHIFT',
		action = act.ActivateKeyTable {
			name = 'resize_mode',
			one_shot = false,
		},
	},
	{
		key = "\\",
		mods = "ALT",
		action = wezterm.action.SplitHorizontal { domain =
		'CurrentPaneDomain' }
	},
	{
		key = "-",
		mods = "ALT",
		action = wezterm.action.SplitVertical { domain =
		'CurrentPaneDomain' }
	},
	{ key = "z",          mods = "ALT",       action = "TogglePaneZoomState" },
	{ key = "x",          mods = "ALT",       action = wezterm.action.CloseCurrentPane { confirm = false }, },
	{ key = "x",          mods = "ALT|SHIFT", action = wezterm.action.CloseCurrentTab { confirm = false } },
	{ key = 'LeftArrow',  mods = "CTRL",      action = act.ActivatePaneDirection 'Left' },
	{ key = 'h',          mods = "CTRL",      action = act.ActivatePaneDirection 'Left' },
	{ key = 'RightArrow', mods = "CTRL",      action = act.ActivatePaneDirection 'Right' },
	{ key = 'l',          mods = "CTRL",      action = act.ActivatePaneDirection 'Right' },
	{ key = 'UpArrow',    mods = "CTRL",      action = act.ActivatePaneDirection 'Up' },
	{ key = 'k',          mods = "CTRL",      action = act.ActivatePaneDirection 'Up' },
	{ key = 'DownArrow',  mods = "CTRL",      action = act.ActivatePaneDirection 'Down' },
	{ key = 'j',          mods = "CTRL",      action = act.ActivatePaneDirection 'Down' },
	{ key = 't',          mods = 'ALT',       action = act.ActivateTabRelative(1) },
	{ key = 'T',          mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) },
}

config.key_tables = {
	resize_mode = {
		{ key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left', 1 } },
		{ key = 'h',          action = act.AdjustPaneSize { 'Left', 1 } },
		{ key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
		{ key = 'l',          action = act.AdjustPaneSize { 'Right', 1 } },
		{ key = 'UpArrow',    action = act.AdjustPaneSize { 'Up', 1 } },
		{ key = 'k',          action = act.AdjustPaneSize { 'Up', 1 } },
		{ key = 'DownArrow',  action = act.AdjustPaneSize { 'Down', 1 } },
		{ key = 'j',          action = act.AdjustPaneSize { 'Down', 1 } },
		-- Cancel the mode by pressing escape
		{ key = 'Escape',     action = 'PopKeyTable' },
	},
	window_mode = {
		{ key = 'x', action = act.CloseCurrentPane { confirm = false } },
		{ key = 'x', mods = "SHIFT",                                   action = act.CloseCurrentTab { confirm = false } },
		{ key = 'c', action = act.SpawnTab 'DefaultDomain' },
		{ key = 'c', mods = "CTRL",                                    action = act.SpawnTab 'CurrentPaneDomain' },
		{ key = 'h', action = act.ActivatePaneDirection 'Left' },
		{ key = 'l', action = act.ActivatePaneDirection 'Right' },
		{ key = 'k', action = act.ActivatePaneDirection 'Up' },
		{ key = 'j', action = act.ActivatePaneDirection 'Down' },
		{ key = 'v', action = act.CopyMode { SetSelectionMode = 'Cell' },
		},
		{ key = "z", action = "TogglePaneZoomState" },
		{ key = 'n', action = act.SwitchWorkspaceRelative(1) },
		{
			key = 'w',
			action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
		},
		{ key = 'p', action = act.SwitchWorkspaceRelative(-1) },
		{
			key = "\\",
			action = wezterm.action.SplitHorizontal { domain =
			'DefaultDomain' }
		},
		{
			key = "-",
			action = wezterm.action.SplitVertical { domain =
			'DefaultDomain' }
		},
		{
			key = "\\",
			mods = "CTRL",
			action = wezterm.action.SplitHorizontal { domain =
			'CurrentPaneDomain' }
		},
		{
			key = "-",
			mods = "CTRL",
			action = wezterm.action.SplitVertical { domain =
			'CurrentPaneDomain' }
		},
		{ key = 't', action = act.ActivateTabRelative(1) },
		{ key = 'T', mods = 'SHIFT',                          action = act.ActivateTabRelative(-1) },

	},
}


return config
