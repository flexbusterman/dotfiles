return {
	{
		"L3MON4D3/LuaSnip",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/plugins/luasnippets/" })
			require("luasnip").filetype_extend("javascript", { "javascriptreact" })
			require("luasnip").filetype_extend("javascript", { "html" })
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = false,
		config = true,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup({
				window = {
					documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					-- ['<C-Space>'] = cmp.mapping.complete {},
					["<C-Space>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
						-- if cmp.visible() then
						-- 	cmp.select_next_item()
						-- elseif luasnip.expand_or_locally_jumpable() then
						-- 	luasnip.expand_or_jump()
						-- else
						-- 	fallback()
						-- end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
						-- if cmp.visible() then
						-- 	cmp.select_prev_item()
						-- elseif luasnip.locally_jumpable(-1) then
						-- 	luasnip.jump(-1)
						-- else
						-- 	fallback()
						-- end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
