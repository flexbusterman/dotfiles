return {
	"nvim-orgmode/orgmode",
	-- event = "VeryLazy",
	-- ft = { "org" },
	config = function()
		-- set statusline to report active clockclock
		vim.opt.statusline = "%{v:lua.orgmode.statusline()}"
		require("orgmode").setup({
			org_agenda_files = "~/ORGMODE/**/*",
			org_agenda_start_on_weekday = false,
			org_default_notes_file = "~/ORGMODE/refile.org",
			win_split_mode = "tabnew",
			org_priority_highest = "A",
			org_priority_default = "D",
			org_priority_lowest = "F",
			org_capture_templates = { t = { description = "Task", template = "* TODO %?\n  SCHEDULED: %t" } },
			org_todo_keywords = { "TODO", "NEXT", "LEARN", "|", "DONE" },
		})
	end,
}
