return {
	'github/copilot.vim',
	config = function()
		require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/flex/plugins/luasnippets/" })
	end
}
