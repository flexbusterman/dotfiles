vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-[>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<esc>', '<esc><Plug>(copilot-cancel)')

vim.g.copilot_filetypes = {
	["*"] = true,
	["markdown"] = false,
	["vimwiki"] = false,
	-- ["javascript"] = true,
	-- ["typescript"] = true,
	-- ["lua"] = true,
	-- ["rust"] = true,
	-- ["c"] = true,
	-- ["c#"] = true,
	-- ["c++"] = true,
	-- ["go"] = true,
	-- ["python"] = true,
	-- ["unix"] = true,
	-- ["bash"] = true,
	-- ["vue"] = true,
	-- ["json"] = true,
	-- ["zsh"] = true,
	-- ["sh"] = true,
	-- ["supercollider"] = true,
}
