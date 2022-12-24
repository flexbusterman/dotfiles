-- vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true

-- indenting
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = 0
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
-- vim.opt.colorcolumn = "80"
vim.opt.filetype.plugin = "on"
vim.g.cmdheight = 1
vim.g.nocompatible = true
vim.opt.syntax = "on"

vim.fn.setreg('s', 'dt_xllla-lla-lllr lla_lla_0j')
