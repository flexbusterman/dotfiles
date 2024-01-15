return {
	'tpope/vim-fugitive',
	config = function()
		-- get the change from the left
		vim.keymap.set("n", "gh", ":diffget //2<CR>")
		-- get the change from the right
		vim.keymap.set("n", "gl", ":diffget //3<CR>")
		-- jump to next change and scroll to top
		vim.keymap.set("n", "gj", "]czt")
		-- jump to previous change and scroll to top
		vim.keymap.set("n", "gk", "[czt")
	end
}
