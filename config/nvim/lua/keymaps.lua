Default_keyopts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

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
map("n", "mpr", ":MarkdownPreview<cr>", Default_keyopts)
map("n", "mtt", ":TableModeToggle<cr>", Default_keyopts)
map("n", "mtz", ":Tableize<cr>", Default_keyopts)
map("n", "mts", ":TableSort<cr>", Default_keyopts)
map("v", "mx", ":call unicoder#selection()<cr>", Default_keyopts)
map("n", "mpi", ":call  mdip#MarkdownClipboardImage()<cr>", Default_keyopts)

-- Telescope
vim.keymap.set("n", "<leader>f", function()
	require("telescope.builtin").find_files()
end, Default_keyopts)
vim.keymap.set("n", "<leader>b", function()
	require("telescope.builtin").buffers()
end, Default_keyopts)
vim.keymap.set("n", "<leader>h", function()
	require("telescope.builtin").help_tags()
end, Default_keyopts)
vim.keymap.set("n", "<leader>r", function()
	require("telescope.builtin").lsp_references()
end, Default_keyopts)
vim.keymap.set("n", "<leader>d", function()
	require("telescope.builtin").lsp_definitions()
end, Default_keyopts)
vim.keymap.set("n", "<leader>x", function()
	require("telescope.builtin").live_grep()
end, Default_keyopts)
vim.keymap.set("n", "<leader>p", function()
	require("telescope").extensions.projects.projects({})
end, Default_keyopts)
vim.keymap.set("n", "<leader>gdl", function()
	require("telescope").extensions.advanced_git_search.diff_commit_line({})
end, Default_keyopts)
vim.keymap.set("n", "<leader>gdf", function()
	require("telescope").extensions.advanced_git_search.diff_commit_file({})
end, Default_keyopts)
vim.keymap.set("n", "<leader>gdb", function()
	require("telescope").extensions.advanced_git_search.diff_branch_file({})
end, Default_keyopts)
vim.keymap.set("n", "<leader>o", function()
	require("telescope.builtin").oldfiles({})
end, Default_keyopts)
vim.keymap.set("n", "<leader>o", function()
	require("telescope.builtin").oldfiles({})
end, Default_keyopts)
vim.keymap.set("n", "<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find({})
end, Default_keyopts)
---GIT
map("n", "<leader>gm", ':!git commit -am "devops: ', { noremap = true, silent = false })
map("n", "<leader>gp", ":!git push<cr>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>gb", function()
	require("telescope.builtin").git_branches({})
end, Default_keyopts)
vim.keymap.set("n", "<leader>gs", function()
	require("telescope.builtin").git_status({})
end, Default_keyopts)
vim.keymap.set("n", "<space>f", function()
	vim.lsp.buf.format({ async = true })
end, Default_keyopts)
