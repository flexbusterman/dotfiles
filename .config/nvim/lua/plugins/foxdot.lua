return {
	dir = "/home/flex/.local/src/foxdot.vim",
	ft = "python",
	config = function()
		-- vim.keymap.set("n", "<CR>", ":FoxDotEval<CR>")
		vim.keymap.set("n", "<leader>.", ":FoxDotHush<CR>")
		vim.g.sclang_executable_path = '/usr/bin/sclang'
		vim.g.python_executable_path = '/usr/bin/python3'
	end
}
