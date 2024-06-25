return {
	"vimwiki/vimwiki",
	config = function()
		vim.o.wrap = true
		vim.o.linebreak = true
		vim.keymap.set("n", "j", "gj")
		vim.keymap.set("n", "k", "gk")
		vim.keymap.set("n", "h", "gh")
		vim.keymap.set("n", "l", "gl")
		vim.keymap.set("n", "0", "g0")
		vim.keymap.set("n", "$", "g$")
		vim.keymap.set("n", "<leader>i", ":VimwikiIndex<CR>")
		vim.g.vimwiki_list = {
			{
				path = "/home/flex/Dropbox/NOTES/",
				syntax = "markdown",
				ext = ".md",
			},
		}
	end,
}
