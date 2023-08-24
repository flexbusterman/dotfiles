local cmp = require'cmp'

cmp.setup({
snippet = {
	expand = function(args)
	require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
	end,
	},
sources = {
	{ name = 'tags' },
	{ name = 'luasnip' }, -- For luasnip users.
}
})
