-- vim.keymap.set('i', '<C-N>', '<Nop>')
-- vim.keymap.set('i', '<C-N>', '<Plug>(copilot-next)')
-- vim.keymap.set('i', '<C-P>', '<Nop>')
-- vim.keymap.set('i', '<C-P>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<esc>', '<esc><Plug>(copilot-cancel)')

vim.g.copilot_filetypes = {
	["*"] = true,
	["markdown"] = false,
	["vimwiki"] = false,
	["mail"] = false,
	["text"] = false,
	["supercollider"] = false,
	-- ["tidal"] = false,
}
