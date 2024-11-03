return { -- Autocompletion
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_lua").lazy_load({
					paths = "/home/flex/.config/nvim/lua/custom/plugins/luasnippets/",
				})
				require("luasnip").filetype_extend("javascript", { "javascriptreact" })
				require("luasnip").filetype_extend("javascript", { "html" })
			end,
			build = (function()
				-- Build Step is needed for regex support in snippets
				-- This step is not supported in many windows environments
				-- Remove the below condition to re-enable on windows
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},
		"saadparwaiz1/cmp_luasnip",

		-- Adds other completion capabilities.
		--  nvim-cmp does not ship with all sources by default. They are split
		--  into multiple repos for maintenance purposes.
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",

		-- If you want to add a bunch of pre-configured snippets,
		--    you can use this plugin to help you. It even has snippets
		--    for various frameworks/libraries/etc. but you will have to
		--    set up the ones that are useful for you.
		-- 'rafamadriz/friendly-snippets',
	},
	config = function()
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },

			-- For an understanding of why these mappings were
			-- chosen, you will need to read `:help ins-completion`
			--
			-- No, but seriously. Please read `:help ins-completion`, it is really good!
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.config.disable,
				["<C-p>"] = cmp.config.disable,
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-u>"] = cmp.mapping.scroll_docs(4),
				-- ["<C-Space>"] = cmp.mapping.complete({}),
				["<C-l>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm({
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						})
					else
						-- cmp.complete({})
						fallback()
					end
				end, { "i", "s" }),
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
			sources = {
				{ name = "buffer" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			},
		})
	end,
}
