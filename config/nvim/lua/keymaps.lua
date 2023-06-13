Default_keyopts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
local wk = require("which-key")

-- Tabs
map("x", "-", '!while read i; do echo "- $i"; done <cr>', { noremap = true, silent = false })
map("x", "1", "!nl -s'. ' -w 1 <cr>", { noremap = true, silent = false })

-- Splits
map("n", "-", ":split<Return>", Default_keyopts)
map("n", "|", ":vsplit<Return>", Default_keyopts)
map("n", "<S-a>", "gg<S-v>G", Default_keyopts)
map("n", "<C-z>", ":q!<Return>", Default_keyopts)
map("n", "<C-s>", ":w<Return>", Default_keyopts)

--- Move line
-- map("n", "<A-j>", ":m +1 <Return>", Default_keyopts
-- map("n", "<A-k>", ":m -2 <Return>", Default_keyopts)

--- Switch buffers
map("n", "t", ":bn<Return>", Default_keyopts)
map("n", "T", ":bp<Return>", Default_keyopts)

-- MARKDOWN
wk.register({
	p = {
		r = { ":MarkdownPreview<cr>" },
		i = { ":call  mdip#MarkdownClipboardImage()<cr>" },
	},
	x = { ":call unicoder#selection()<cr>" },
	t = {
		name = "table",
		t = { ":TableModeToggle<cr>" },
		z = { ":Tableize<cr>" },
		s = { ":TableSort<cr>" },
	}
}
, { prefix = "<leader>m" })

-- Telescope
wk.register(
	{
		name = "telescope",
		f = { function() require("telescope.builtin").find_files() end, "find_files" },
		b = { function() require("telescope.builtin").buffers() end, "buffers" },
		o = { function() require("telescope.builtin").oldfiles() end, "oldfiles" },
		j = { function() require("telescope.builtin").jumplist() end, "jumplist" },
		h = { function() require("telescope.builtin").help_tags() end, "help_tags" },
		x = { function() require("telescope.builtin").live_grep() end, "telegrep" },
		p = { function() require("telescope").extensions.projects.projects({}) end, "projects" },
		["/"] = { function() require("telescope.builtin").current_buffer_fuzzy_find({}) end, "fuzzyfind" },
		["mm"] = { function() require("telescope.builtin").marks() end, "marks" },
		l = {
			name = "lsp",
			f = { function() require("telescope.builtin").diagnostics() end, "diagnostics" },
			r = { function() require("telescope.builtin").lsp_references() end, "lsp_references" },
			d = { function() require("telescope.builtin").lsp_definitions() end, "lsp_definitions" },
			i = { function() require("telescope.builtin").lsp_implementations() end, "lsp_implementations" },
		},
		g = {
			name = "git",
			d = {
				name = "diff",
				l = { function() require("telescope").extensions.advanced_git_search.diff_commit_line({}) end, "diff_commit_line" },
				f = { function() require("telescope").extensions.advanced_git_search.diff_commit_file({}) end, "diff_commit_file" },
				b = { function() require("telescope").extensions.advanced_git_search.diff_branch_file({}) end, "diff_branch_file" },
			},
			m = { ':!git commit -am "devops:', "git commit", silent = false },
			p = { ":!git push<cr>", "git push", silent = false },
			b = { function() require("telescope.builtin").git_branches({}) end, "git_branches" },
			s = { function() require("telescope.builtin").git_status({}) end, "git_status" },
		}
	}
	, { prefix = "<leader>" })

---GIT
vim.keymap.set("n", "<space>f", function()
	vim.lsp.buf.format({ async = true })
end, Default_keyopts)
