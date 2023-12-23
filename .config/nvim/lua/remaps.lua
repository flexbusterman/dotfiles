--  _  __          _     _           _ _
-- | |/ /___ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
-- | ' // _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
-- | . \  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
-- |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
--           |___/                             |___/
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n", "<leader>h", vim.cmd.Ex, { desc = 'netrw filemanager' })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n" }, "<leader>j", "<nop>")
vim.keymap.set({ "n" }, "<leader>j", vim.cmd.w)
vim.keymap.set({ "n" }, "<leader>q", vim.cmd.q)
vim.keymap.set({ "n" }, "<leader>Q", vim.cmd.x)
vim.keymap.set({ "n" }, "<leader>d", "<nop>")

vim.keymap.set({ "n" }, "<C-h>", "<C-w>h")
vim.keymap.set({ "n" }, "<C-j>", "<C-w>j")
vim.keymap.set({ "n" }, "<C-k>", "<C-w>k")
vim.keymap.set({ "n" }, "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- no duplicate lines
vim.keymap.set("n", "<leader>l", ":g/^\\s\\+$/s/\\s\\+//e <CR> <bar> :silent! g/^$/,/./-j<CR><c-o>")

vim.keymap.set("n", "<leader>k", ":EslintFixAll<CR>")
vim.keymap.set("x", "<leader>k", ":EslintFixAll<CR>")

vim.keymap.set("n", "tt", ":tab split<CR>")

-- Smart Tag Jump function
_G.smart_tag_jump = function()
	local word = vim.fn.expand('<cword>')
	local taglist = vim.fn.taglist('^' .. word .. '$')
	if #taglist == 1 then
		vim.cmd('tag ' .. word)
	elseif #taglist > 1 then
		vim.cmd('tjump ' .. word)
	end
end
vim.keymap.set("n", "g]", "<cmd>lua _G.smart_tag_jump()<CR>")

vim.keymap.set("n", "{", "{b")
vim.keymap.set("n", "}", "}w")

