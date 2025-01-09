return {
	"vimwiki/vimwiki",
	setup = function()
		vim.g.vimwiki_list = {
			{
				path = "~/Dropbox/MD/",
				syntax = "markdown",
				ext = ".md",
			},
		}
	end,
}
