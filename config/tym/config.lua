-- At first, you need to require tym module
local tym = require("tym")

tym.set("font", "Comic Code Ligatures 9")

-- set by table
tym.set_config({
	--	shell = "/run/current-system/sw/bin/zsh",
	cursor_shape = "block",
	autohide = true,
	padding_horizontal = 0,
	padding_vertical = 0,
	scale = 100,
	silent = true,
	bold_is_bright = true,
	cell_height= 90,
	background_image = '/home/t1g3pf4c3/pictures/amongus0.jpg'
})

tym.set_keymaps({
	["<Ctrl><Shift>k"] = function()
		local s = tym.get("scale") + 10
		tym.set("scale", s)
		-- tym.notify("scale" .. s .. "%")
		return true -- notification is shown and `Y` will be inserted
	end,
	["<Ctrl><Shift>j"] = function()
		local s = tym.get("scale") - 10
		tym.set("scale", s)
		-- tym.notify("scale:" .. s .. "%")
		return true -- notification is shown and `Y` will be inserted
	end,
	["<Ctrl><Shift>t"] = function()
		tym.put("tmux attach || tmux")
		tym.send_key("Return")
		-- return true -- notification is shown and `Y` will be inserted
	end,
})
-- TMUX
tym.set_keymaps({
	["<Ctrl><Alt>k"] = function()
		tym.send_key("<Ctrl>b")
	end,
	["<Ctrl><Alt>t"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("<Ctrl>b")
		tym.send_key("N")
	end,
	["<Ctrl><Alt><Shift>t"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("<Ctrl>b")
		tym.send_key("P")
	end,
	["<Alt>t"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("N")
	end,
	["<Alt>f"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("Z")
	end,
	["<Alt><Shift>t"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("P")
	end,
	["<Alt>s"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("s")
	end,
	["<Alt>o"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("h")
	end,
	["<Alt><Return>"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("b")
	end,
	["<Alt>b"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("b")
	end,
	["<Alt>g"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("g")
	end,
	["<Alt>y"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("y")
	end,
	["<Alt>m"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("m")
	end,
	["<Alt>x"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("x")
	end,
	["<Alt>u"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("u")
	end,
	["<Ctrl><Alt>x"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("<Ctrl>b")
		tym.send_key("x")
	end,
})
