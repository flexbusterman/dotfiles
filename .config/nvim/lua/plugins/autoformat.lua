return { -- Autoformat
	"stevearc/conform.nvim",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	opts = {
		notify_on_error = false,
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 500,
		},
		formatters_by_ft = {
			sh = { "shfmt" },
			bash = { "shfmt" },
			lua = { "stylua" },
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
			python = {
				-- "isort",
				-- "black",
				"pyright",
			},
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			-- javascript = { { "prettierd", "prettier" } },
		},
	},
	vim.keymap.set({ "n", "v" }, "<leader>mp", function()
		require("conform").format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 500,
		})
	end, { desc = "Format current buffer" }),
}
