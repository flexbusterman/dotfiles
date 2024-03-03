return {
	'christoomey/vim-titlecase',
	config = function()
		vim.keymap.set({"n", "v" }, "<leader>t", "<Plug>TitlecaseLine", { silent = true })
	end
}
