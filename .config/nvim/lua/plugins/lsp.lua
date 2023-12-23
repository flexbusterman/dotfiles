return {
	-- Collection of configurations for built-in LSP client
	'neovim/nvim-lspconfig',
	{
		-- Autocompletion plugin
		'hrsh7th/nvim-cmp',
		config = function()
			-- Add additional capabilities supported by nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require('lspconfig')
			-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
			local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup {
					-- on_attach = my_custom_on_attach,
					capabilities = capabilities,
				}
			end

			local luasnip = require 'luasnip'
			local cmp = require 'cmp'
			require('luasnip.loaders.from_vscode').lazy_load()

			cmp.setup {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					-- ['<C-Space>'] = cmp.mapping.complete {},
					['<C-Space>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
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
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
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
					end, { 'i', 's' }),
				}),
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				},
			}
		end
	},
	-- LSP source for nvim-cmp
	'hrsh7th/cmp-nvim-lsp',
	-- Snippets source for nvim-cmp
	'saadparwaiz1/cmp_luasnip',
	{
		-- Snippets plugin
		'L3MON4D3/LuaSnip',
		config = function()
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/plugins/luasnippets/" })
			require('luasnip').filetype_extend("javascript", { "javascriptreact" })
			require('luasnip').filetype_extend("javascript", { "html" })
		end
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"vuels",
					"tsserver",
					"jsonls",
					"pyright",
				}
			})
		end
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			local lspconfig = require('lspconfig')
			lspconfig.lua_ls.setup {}
			lspconfig.bashls.setup {}
			lspconfig.vuels.setup {}
			lspconfig.tsserver.setup {}
			lspconfig.jsonls.setup {}
			lspconfig.pyright.setup {}

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
					end, opts)
					vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<leader>k', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})
		end
	}
}
