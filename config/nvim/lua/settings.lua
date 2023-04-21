Opt = vim.opt
G = vim.g
----------------------------
Opt.clipboard = "unnamedplus"
----------------------------
Opt.mouse = "a"
----------------------------
Opt.spell = true
Opt.spelllang = { "en_us", "ru" }
----------------------------
Opt.cursorline = true
Opt.cursorcolumn = true
----------------------------
Opt.number = true
Opt.title = true
----------------------------
Opt.shiftwidth = 2
Opt.tabstop = 2
Opt.autoindent = true
----------------------------
Opt.hlsearch = true
----------------------------
-- Opt.autochdir = true
----------------------------
Opt.ignorecase = true
Opt.smartcase = true
----------------------------
Opt.wrap = false
Opt.laststatus = 3
----------------------------
Opt.timeoutlen = 200

Opt.conceallevel = 2
Opt.ch = 0

Opt.undofile = true

G.loaded_python3_provider = 0
G.loaded_perl_provider = 0
vim.g.mapleader = "\\" -- make sure to set `mapleader` before lazy so your mappings are correct

