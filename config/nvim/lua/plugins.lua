require("lazy").setup({
	-- Colortheme
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("customization")
		end,
	},
	-- CSS colors
	-- { "norcalli/nvim-colorizer.lua", config = true },
	{ "brenoprata10/nvim-highlight-colors", config = true },
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
		},
	},
	-- QUALITY OF NVIM
	{
		"windwp/nvim-autopairs",
		config = true
	},
	"tpope/vim-repeat",
	-- "tpope/vim-surround",
	"kylechui/nvim-surround",
	-- WHICH KEY
	{
		"folke/which-key.nvim",
		config = true
	},
	-- BUfferline
	{
		"akinsho/bufferline.nvim",
		config = true
	},
	{
		"nvim-treesitter/nvim-treesitter",
		-- run = ":TSUpdate",
		config = function()
			require("setup.treesitter")
		end,
	},
	-- Tmux integration
	-- { "alexghergh/nvim-tmux-navigation" },
	{
		"aserowy/tmux.nvim",
		opts = {
			copy_sync = {
				redirect_to_clipboard = true,
			},
		},
	},
	-- NEORG
	{
		"nvim-neorg/neorg",
		opts = {
			load = {
				["core.defaults"] = {},
				["core.integrations.treesitter"] = {},
				["core.looking-glass"] = {},
				["core.integrations.nvim-cmp"] = {},
				["core.ui"] = {},
				["core.export"] = {},
				["core.export.markdown"] = {},
				["core.concealer"] = {
					config = {
						folds = true,
						icon_preset = "varied",
					}
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							work = "~/projects/work/webbee/notes"
						}
					}
				},
				["core.presenter"] = { config = { zen_mode = "zen-mode" } },
				["core.completion"] = { config = { engine = "nvim-cmp" } },
				["core.promo"] = {},
				["core.journal"] = {}

			},
		},
		ft = "norg",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "arthurxavierx/vim-unicoder",
			-- "joom/latex-unicoder.vim",
			"hrsh7th/nvim-cmp",
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "ahmedkhalf/project.nvim", "aaronhallaert/advanced-git-search.nvim",
			"tpope/vim-fugitive" },
		opts = {
			defaults = {
				theme = "ivy",
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "-E", ".git", "--hidden" },
				},
				live_grep = {
					show_hidden = true,
					hidden = true,
				},
			},
			extentions = { "projects", "advanced_git_search" },
		},
	},
	{
		"ahmedkhalf/project.nvim",
		lazy = true,
		config = function()
			require("project_nvim").setup({
				show_hidden = true,
				manual_mode = true,
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				silent_chdir = true,
				detection_methods = { "lsp", "pattern" },
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
				update_focused_file = {
					enable = true,
					update_root = true,
				},
			})
		end,
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		-- event = "InsertEnter",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
			'towolf/vim-helm',
			-- { "j-hui/fidget.nvim", config = true },
		},
		config = function()
			require("setup.lsp")
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		lazy = true,
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			null_ls.setup({
				sources = {
					formatting.shfmt,
					formatting.sqlfmt,
					formatting.prettier,
					formatting.prettier,
					formatting.yamlfix,
					formatting.ansiblelint,
					formatting.shellharden,
					formatting.black,
					diagnostics.pylint,
					diagnostics.yamllint,
					diagnostics.shellharden,
					diagnostics.shellcheck,
					-- diagnostics.ansible_lint,
				},
			})
		end,
		event = "InsertEnter",
		dependencies = { "nvim-lua/plenary.nvim", "jay-babu/mason-null-ls.nvim", "williamboman/mason.nvim" },
	},
	{ "jay-babu/mason-null-ls.nvim",        lazy = true,  opts = { automatic_setup = true } },

	-- Comments
	{ "numToStr/Comment.nvim",              config = true },
	-- CMP
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		lazy = true,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("setup.cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		dependencies = {
			"saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" }
	},
	-- Git
	{ "lewis6991/gitsigns.nvim",    config = true },
	{ "tpope/vim-fugitive" },

	{ "dhruvasagar/vim-table-mode", cmd = "TableModeToggle" },
	{ "jbyuki/venn.nvim",           cmd = "VBox" },
	{ "ray-x/go.nvim",              ft = "go",                                 config = true },
	{ "rodjek/vim-puppet",          ft = { "pp", "puppet" } },
	{ "powerman/vim-plugin-ruscmd", ft = { "md", "markdown", "neorg", "norg" } },
	{
		"cuducos/yaml.nvim",
		ft = { "yaml" }, -- optional
		dependencies = {
			-- "nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
		},
	},
	{
		'glacambre/firenvim',
		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
		end
	},
	{
		"folke/zen-mode.nvim",
		-- windos = {
		-- 	width = 120, -- width of the Zen window
		-- },
		-- opts = {
		-- 	plugins = {
		-- 		-- disable some global vim options (vim.o...)
		-- 		-- comment the lines to not apply the options
		-- 		options = {
		-- 			enabled = true,
		-- 			ruler = true,            -- disables the ruler text in the cmd line area
		-- 			showcmd = true,          -- disables the command in the last line of the screen
		-- 		},
		-- 		twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
		-- 		gitsigns = { enabled = true }, -- disables git signs
		-- 		tmux = { enabled = true },
		-- 	},
		-- },
	},
	{
		'michaelb/sniprun',
		build = "sh ./install.sh 1",
		config = function()
			require("sniprun").setup({
				display = { "Terminal" },
				interpreter_options = {
					Generic = {
						DockerConfig = {
							supported_filetypes = { "dockerfile", "Dockerfile" },
							extension = "dockerfile",
							interpreter = "docker build -t tmp . -f",
							compiler = "",
							exe_name = "",
							boilerplate = ""
						},
						DockerCompose = {
							supported_filetypes = { "yaml" },
							extension = ".yaml",
							compiler = "",
							interpreter = "podman-compose up -f",
							exe_name = "",
							boilerplate = ""
						},
						Gitignore = {
							supported_filetypes = { "gitignore" },
							extension = ".gitignore",
							compiler = "",
							interpreter = "cat",
							exe_name = "",
							boilerplate = ""
						},

					},

				},
				selected_interpreters = { "Generic", "Neorg_original" }
			})
		end
	},
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ 'akinsho/toggleterm.nvim', version = "*", config = true },
	{ 'taybart/b64.nvim' },

	-- {
	-- 	'jubnzv/mdeval.nvim',
	-- 	config = function()
	-- 		require("mdeval").setup({
	-- 			-- Don't ask before executing code blocks
	-- 			require_confirmation = false,
	-- 			-- Change code blocks evaluation options.
	-- 			eval_options = {
	-- 				-- Set custom configuration for C++
	-- 				-- Add new configuration for Racket
	-- 				yaml = {
	-- 					command = { "echo" }, -- Command to run interpreter
	-- 					language_code = "yaml", -- Markdown language code
	-- 					exec_type = "interpreted", -- compiled or interpreted
	-- 					extension = "yaml",   -- File extension for temporary files
	-- 				},
	-- 				dockerfile = {
	-- 					command = { "echo" }, -- Command to run interpreter
	-- 					language_code = "dockerfile", -- Markdown language code
	-- 					exec_type = "interpreted", -- compiled or interpreted
	-- 					extension = "dockerfile",   -- File extension for temporary files
	-- 				},
	-- 			},
	-- 		})
	-- 	end
	-- }
	--
	-- {
	-- 	'chipsenkbeil/distant.nvim',
	-- 	branch = 'v0.3',
	-- 	config = function()
	-- 		require('distant').setup()
	-- 	end
	-- },
	{
		'xiyaowong/transparent.nvim',
		config =
				function()
					require("transparent").setup({ -- Optional, you don't have to run setup.
						groups = {            -- table: default groups
							'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
							'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
							'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
							'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
							'EndOfBuffer',
						},
						extra_groups = {}, -- table: additional groups that should be cleared
						exclude_groups = {}, -- table: groups you don't want to clear
					})
				end
	}
	"github/copilot.vim",
})
