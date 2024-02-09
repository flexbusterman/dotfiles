return {
	-- Prettier
	{
		"MunifTanjim/prettier.nvim",
		config = function()
			local prettier = require("prettier")
			prettier.setup({
				bin = "prettier", -- or `'prettier'` (v0.23.3+)
				filetypes = {
					"css",
					"graphql",
					"html",
					"javascript",
					"javascriptreact",
					"json",
					"less",
					"markdown",
					"scss",
					"typescript",
					"typescriptreact",
					"yaml",
				},
				cli_options = {
					semi = false,
					use_tabs = true,
					tab_width = 2,
					single_quote = true,
					config_precedence = "prefer-file", -- or "cli-override" or "file-override"
					-- arrow_parens = "always",
					-- bracket_spacing = true,
					-- bracket_same_line = false,
					-- embedded_language_formatting = "auto",
					-- end_of_line = "lf",
					-- html_whitespace_sensitivity = "css",
					-- -- jsx_bracket_same_line = false,
					-- print_width = 80,
					-- prose_wrap = "preserve",
					-- quote_props = "as-needed",
					-- single_attribute_per_line = false,
					-- single_quote = false,
					-- trailing_comma = "es5",
					-- vue_indent_script_and_style = false,
				},
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					javascript = {
						"prettier",
					},
					typescript = {
						"prettier",
					},
					javascriptreact = {
						"prettier",
					},
					typescriptreact = {
						"prettier",
					},
					svelte = {
						"prettier",
					},
					css = {
						"prettier",
					},
					html = {
						"prettier",
					},
					json = {
						"prettier",
					},
					markdown = {
						"prettier",
					},
					lua = {
						"stylua",
					},
					python = {
						"isort",
						"black",
					},
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format current buffer" })
		end,
	},
}
