return {
	"christoomey/vim-titlecase",
	config = function()
		vim.keymap.set({ "n", "v" }, "<leader>tc", "<Plug>TitlecaseLine", { silent = true })
	end,
}
