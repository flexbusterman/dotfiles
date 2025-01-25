return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set("i", "<c- >", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
		})
		vim.keymap.set("i", "<c-n>", "<Plug>(copilot-next)")
		vim.keymap.set("i", "<c-p>", "<Plug>(copilot-previous)")
		vim.keymap.set("n", "<c- >", "<Plug>(copilot-suggest)")
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_filetypes = {
			org = false,
			supercollider = false,
			taskedit = false,
			vimwiki = false,
			python = false,
			markdown = false,
			tex = false,
		}
	end,
}
