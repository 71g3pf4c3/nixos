require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "yaml", "go", "dockerfile" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>v", --init selectiin
			node_incremental = "<CR>", -- upper node
			scope_incremental = "<TAB>", -- upper scope
			node_decremental = "<S-TAB>", -- down node
		},
	},
})
-- local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
-- parser_config.gotmpl = {
--   install_info = {
--     url = "https://github.com/ngalaiko/tree-sitter-go-template",
--     files = {"src/parser.c"}
--   },
--   filetype = "gotmpl",
--   used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
-- }
