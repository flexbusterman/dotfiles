return {
	"vimwiki/vimwiki",
	setup = function()
		vim.g.vimwiki_folding = "syntax"
		vim.g.vimwiki_list = {
			{
				path = { "~/Dropbox/MD/**/*", "/home/flex/Dropbox/MD/**/*" },
				syntax = "markdown",
				ext = ".md",
			},
		}
	end,
}
