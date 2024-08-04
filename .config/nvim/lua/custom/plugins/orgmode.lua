return {
	"nvim-orgmode/orgmode",
	-- event = "VeryLazy",
	-- ft = { "org" },
	config = function()
		require("orgmode").setup({
			org_agenda_files = "~/Dropbox/ORGMODE/**/*",
			org_agenda_start_on_weekday = false,
			org_default_notes_file = "~/Dropbox/ORGMODE/refile.org",
			win_split_mode = "tabnew",
			org_priority_highest = "A",
			org_priority_lowest = "F",
			org_priority_default = "D",
			org_capture_templates = { t = { description = "Task", template = "* TODO %?\n  SCHEDULED: %t" } },
		})
	end,
}
