-- vim.opt.guicursor = ""

-- relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- indenting
vim.opt.expandtab = false
vim.opt.tabstop = 2
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

-- netrw stuff {{{
vim.cmd([[
	nnoremap - :Explore<CR>
	autocmd FileType netrw setl bufhidden=delete
]])
vim.g.netrw_banner=0
vim.g.netrw_liststyle=3
vim.g.netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"

vim.api.nvim_create_autocmd('filetype', {
  pattern = 'netrw',
  desc = 'Better mappings for netrw',
  callback = function()
    local bind = function(lhs, rhs)
      vim.keymap.set('n', lhs, rhs, {remap = true, buffer = true})
    end

    bind('l', '<CR>')
		bind('H', 'u')
		bind('h', '-^')
		bind('l', '<CR>')
		bind('.', 'gh')
		bind('P', '<C-w>z')
		bind('L', '<CR>:Lexplore<CR>')
		bind('<Leader>dd', ':Lexplore<CR>')
  end
})


vim.fn.setreg('s', 'dt_xllla-lla-lllr lla_lla_0j')
