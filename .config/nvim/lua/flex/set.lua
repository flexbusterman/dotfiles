--   ___        _   _
--  / _ \ _ __ | |_(_) ___  _ __  ___
-- | | | | '_ \| __| |/ _ \| '_ \/ __|
-- | |_| | |_) | |_| | (_) | | | \__ \
--  \___/| .__/ \__|_|\___/|_| |_|___/
--       |_|

-- Make relative line numbers default
vim.wo.number = true
vim.opt.nu = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- searching and highlighting
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Enable termguicolors and other visual settings
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.filetype.plugin = "on"
vim.opt.syntax = "on"
vim.opt.scrolloff = 8
vim.opt.wildignore = { '*/node_modules/*' }
vim.opt.modeline = false

-- indenting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftround = true
vim.opt.wrap = true

-- global settings
vim.g.cmdheight = 1
vim.g.nocompatible = true
vim.g.base16_transparent_background = 1
vim.opt.swapfile = false
vim.opt.backup = false

-- Commands
vim.cmd [[ autocmd FileType vimwiki lua require('cmp').setup.buffer { enabled = false } ]]

-- vim.o.breakindent = true
-- vim.opt.guicursor = ""
-- vim.opt.expandtab = false
-- vim.opt.tabstop = 2
-- vim.opt.shiftwidth = 2
-- vim.opt.softtabstop = 2
-- vim.opt.smarttab = true
-- vim.opt.shiftround = true
-- vim.opt.colorcolumn = "80"
-- vim.fn.setreg('s', 'dt_xllla-lla-lllr lla_lla_0j')
-- vim.cmd [[ autocmd ColorScheme * hi Normal ctermbg=none guibg=none ]]
-- au ColorScheme * hi Normal ctermbg=none guibg=none
-- au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red-- kickstart options
