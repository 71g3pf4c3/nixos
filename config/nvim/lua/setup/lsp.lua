-- require("neodev").setup({ })
local lspconfig = require("lspconfig")
local configs = require('lspconfig.configs')
local util = require("lspconfig/util")
local keymap = require("vim.keymap")
-- local lspconfig = require("mason-lspconfig")
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities =
		vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
require("mason").setup()
require("mason-lspconfig").setup()

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end
sign({ name = "DiagnosticSignError", text = "X" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "?" })
sign({ name = "DiagnosticSignInfo", text = "!" })

keymap.set("n", "<space>e", vim.diagnostic.open_float, Default_keyopts)

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
end



lspconfig.gopls.setup({ on_attach = on_attach })
lspconfig.bashls.setup({ on_attach = on_attach })
lspconfig.sqlls.setup({ on_attach = on_attach })
lspconfig.ansiblels.setup({ on_attach = on_attach })
lspconfig.dockerls.setup({ on_attach = on_attach })
lspconfig.pylsp.setup({ on_attach = on_attach })
lspconfig.pyright.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({
	single_file_support = true,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "use" },
			},
		},
	},
})
lspconfig.nil_ls.setup({ on_attach = on_attach })
lspconfig.tsserver.setup({ on_attach = on_attach })
-- lspconfig.helm_ls.setup({ on_attach = on_attach})
lspconfig.yamlls.setup({
	on_attach = on_attach,
	settings = {
		root_dir = [[util.find_git_ancestor]],
		yaml = {
			schemaStore = true,
			completion = true,
			-- schemas = {
			-- 	["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
			-- },
			keyOrdering = false,
		},
	},
})
if not configs.helm_ls then
  configs.helm_ls = {
    default_config = {
      cmd = {"helm_ls", "serve"},
      filetypes = {'helm'},
      root_dir = function(fname)
        return util.root_pattern('Chart.yaml')(fname)
      end,
    },
  }
end

lspconfig.helm_ls.setup {
  filetypes = {"helm"},
  cmd = {"helm_ls", "serve"},
}
vim.api.nvim_create_autocmd({ "bufenter", "bufwinenter" }, {
	pattern = { "*.md" },
	callback = function()
		vim.opt.wrap = true
	end,
})

vim.api.nvim_create_autocmd({ "bufenter", "bufwinenter" }, {
	pattern = { "*.norg" },
	callback = function()
		vim.opt.wrap = true
		Opt.shiftwidth = 1
		Opt.tabstop = 1
	end,
})
vim.api.nvim_create_autocmd({ "bufnewfile", "bufread" }, {
	pattern = { "Jenkinsfile" },
	callback = function()
		vim.opt.filetype = "groovy"
	end,
})
vim.api.nvim_create_autocmd({ "bufnewfile", "bufread" }, {
	pattern = { "*/infrastructure/*.yml", "*/infrastructure/*.yaml"  },
	callback = function()
		vim.opt.filetype = "yaml.ansible"
	end,
})
-- vim.api.nvim_create_autocmd({ "bufnewfile", "bufread" }, {
-- 	pattern = { "*values.yml", "Chart.yaml", "Chart.yml", "*values.yaml" },
-- 	callback = function()
-- 		vim.opt.filetype = "helm"
-- 	end,
-- })
-- vim.api.nvim_create_autocmd({ "bufnewfile", "bufread" }, {
-- 	pattern = { "*values.yml", "Chart.yaml", "Chart.yml", "*values.yaml" },
--   command = "LspStop yamlls",
-- })
vim.api.nvim_create_autocmd({ "bufnewfile", "bufread" }, {
	pattern = { "*.zsh", ".zshrc" },
	callback = function()
		vim.opt.filetype = "sh"
	end,
})
