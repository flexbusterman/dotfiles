-- NOTE: nvim config based on kickstart
-- https://github.com/nvim-lua/kickstart.nvim

-- reading files in lua folder
require("options")
require("keymaps")
require("autocmd")

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- require 'kickstart.plugins.debug',
	require("kickstart.plugins.indent_line"),
	-- reading files in lua/plugins folder
	{ import = "plugins" },
}, {
	change_detection = {
		notify = false,
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
