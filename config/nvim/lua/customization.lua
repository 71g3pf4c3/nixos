opt = vim.opt
g = vim.g

opt.termguicolors = true

require("gruvbox").setup({
	undercurl = true,
	underline = true,
	transparent_mode = false,
	background = light,
	bold = true,
	italic = {
		strings = true,
		comments = true,
		operators = false,
		folds = true,
  },
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "soft", -- can be "hard", "soft" or empty string
	overrides = {},
})

opt.background = "light"
vim.cmd("colorscheme gruvbox")
-- vim.cmd[[highlight Normal ctermbg=NONE guibg=NONE]]

local function timeTheme()
	if tonumber(os.date("%H")) >= 20 or tonumber(os.date("%H")) <= 7 then
		opt.background = "dark"
	else
		opt.background = "light"
		-- cmd[[highlight Normal ctermbg=NONE guibg=NONE]]
	end
end

-- local foo = 1
-- function ToggleTheme()
-- 	if foo%2 == 0 then
-- 		opt.background = "dark"
-- 		foo=foo+1
-- 	else
-- 		opt.background = "light"
-- 		foo=foo+1
-- 		vim.cmd[[highlight Normal ctermbg=NONE guibg=NONE]]
-- 	end
-- end
-- timeTheme()
