-- nvim config based on kickstart.nvim
-- https://github.com/nvim-lua/kickstart.nvim

-- reading files in lua folder
require("options")
require("keymaps")
require("autocmd")
require("health")

-- Install `lazy.nvim` plugin manager
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- reading files in lua/plugins folder
	{ import = "plugins" },
}, {
	change_detection = {
		notify = false,
	},
})
