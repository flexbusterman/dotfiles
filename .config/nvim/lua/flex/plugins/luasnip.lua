return {
	'github/copilot.vim',
	config = function()
		require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/flex/plugins/luasnippets/" })
		require('luasnip').filetype_extend("javascript", { "javascriptreact" })
		require('luasnip').filetype_extend("javascript", { "html" })
	end
}
