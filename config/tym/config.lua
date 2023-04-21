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
})




local function run_shell(command)
	local handle = io.popen(command)
	if (handle~=nil) then
	local result = handle:read("*a")
	handle:close()
	return result
	else
	return "sus"
	end
end
-- tym.notify("" .. run_shell("tmux display-message -p '#S'"))
tym.set("title", "" .. run_shell("tmux display-message -p '#S'"))
tym.set_hooks({
	title = function(t)
		tym.set("title", "" .. run_shell("tmux display-message -p '#S'"))
		return true -- this is needed to cancenl default title application
	end,
})

-- set by table
tym.set_keymaps({
	["<Ctrl><Shift>k"] = function()
		local s = tym.get("scale") + 10
		tym.set("scale", s)
		tym.notify("scale" .. s .. "%")
		return true -- notification is shown and `Y` will be inserted
	end,
	["<Ctrl><Shift>j"] = function()
		local s = tym.get("scale") - 10
		tym.set("scale", s)
		tym.notify("scale:" .. s .. "%")
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
		tym.send_key("<Ctrl>b")
		tym.send_key("Up")
	end,
	["<Ctrl><Alt>j"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("<Ctrl>b")
		tym.send_key("Down")
	end,
	["<Ctrl><Alt>h"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("<Ctrl>b")
		tym.send_key("Left")
	end,
	["<Ctrl><Alt>l"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("<Ctrl>b")
		tym.send_key("Right")
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
	["<Alt><Shift>t"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("P")
	end,
	["<Alt>x"] = function()
		tym.send_key("<Ctrl>b")
		tym.send_key("x")
	end,
})
local remap = function(a, b)
	tym.set_keymap(a, function()
		tym.send_key(b)
	end)
end
tym.set_timeout(
	coroutine.wrap(function()
		tym.put("tmux new -A")
		coroutine.yield(true)
		tym.send_key("<Ctrl>m")
		coroutine.yield(false)
	end),
	100
)

-- tym.set_timeout(function ()
-- 	tym.set("title", "" .. run_shell("tmux display-message -p '#S'"))
-- 	return true
-- end, 3000)
