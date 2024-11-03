return {
	-- Highlight todo, notes, etc in comments
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = false,
		colors = {
			-- Dracula Colors
			-- bg = "#282A36",
			-- fg = "#F8F8F2",
			-- selection = "#44475A",
			-- comment = "#6272A4",
			-- red = "#FF5555",
			-- orange = "#FFB86C",
			-- yellow = "#F1FA8C",
			-- green = "#50fa7b",
			-- purple = "#BD93F9",
			-- cyan = "#8BE9FD",
			-- pink = "#FF79C6",
			-- bright_red = "#FF6E6E",
			-- bright_green = "#69FF94",
			-- bright_yellow = "#FFFFA5",
			-- bright_blue = "#D6ACFF",
			-- bright_magenta = "#FF92DF",
			-- bright_cyan = "#A4FFFF",
			-- bright_white = "#FFFFFF",
			-- menu = "#21222C",
			-- visual = "#3E4452",
			-- gutter_fg = "#4B5263",
			-- nontext = "#3B4048",
			-- white = "#ABB2BF",
			-- black = "#191A21",
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
			info = { "DiagnosticInfo", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
			test = { "Identifier", "#FF00FF" },
			brightgreen = { "BrightGreen", "#69FF94" },
			brightmagenta = { "BrightMagenta", "#FF92DF" },
		},
		keywords = {
			FIX = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			NEXT = { icon = " ", color = "brightmagenta" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
	},
}
