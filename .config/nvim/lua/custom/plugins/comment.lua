return {
	'numToStr/Comment.nvim',
	opts = {
		ignore = '^$'
	},
	config = function()
		vim.api.nvim_set_keymap('n', '<leader>;', '<Plug>(comment_toggle_linewise_current)',
		{ noremap = false, silent = true })
		vim.api.nvim_set_keymap('x', '<leader>;', '<Plug>(comment_toggle_linewise_visual)',
		{ noremap = false, silent = true })
	end
}
