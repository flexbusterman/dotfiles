return {
	"vimwiki/vimwiki",
	config = function()
		vim.o.wrap = true
		vim.o.linebreak = true
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
