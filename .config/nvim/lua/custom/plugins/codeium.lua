return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	ft = {
		"lua",
		"sh",
		"conf",
		"python",
	},
	config = function()
		require("codeium").setup({})
	end,
}
