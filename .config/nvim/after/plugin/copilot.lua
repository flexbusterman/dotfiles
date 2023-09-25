vim.keymap.set('i', '<C-j>', '<Nop>')
vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-k>', '<Nop>')
vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<esc>', '<esc><Plug>(copilot-cancel)')

vim.g.copilot_filetypes = {
	["*"] = true,
	["markdown"] = false,
	["vimwiki"] = false,
	["mail"] = false,
	["text"] = false,
	["supercollider"] = false,
	["tidal"] = false,
}

