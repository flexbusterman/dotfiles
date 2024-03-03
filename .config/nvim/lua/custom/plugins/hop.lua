return {
	'phaazon/hop.nvim',
	branch = 'v2', -- optional but strongly recommended
	config = function()
		require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
		vim.api.nvim_set_keymap("n", "<Leader>f", "<cmd>HopWord<CR>", { noremap = true })
	end
}
