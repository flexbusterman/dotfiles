return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_assume_mapped = true
		-- vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		vim.api.nvim_set_keymap("i", "<C-Space>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		vim.keymap.set("i", "<C-n>", "<Nop>")
		vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)")
		vim.keymap.set("i", "<C-p>", "<Nop>")
		vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)")
		vim.keymap.set("i", "<esc>", "<esc><Plug>(copilot-cancel)")
		vim.g.copilot_filetypes = {
			["*"] = true,
			["markdown"] = false,
			["vimwiki"] = false,
			["mail"] = false,
			["text"] = false,
			["supercollider"] = false,
			["tidal"] = false,
			-- ["python"] = false,
		}
	end,
}
