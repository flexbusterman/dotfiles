return {
	"nvim-orgmode/orgmode",
	config = function()
		vim.api.nvim_create_augroup("AutoFormat", {})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.org",
			group = "AutoFormat",
			callback = function()
				vim.cmd([[silent! %s/\(\*.*\)\n\n\+/\1\r/]])
				local cursor_pos = vim.api.nvim_win_get_cursor(0)
				vim.cmd("normal! gg=G")
				vim.api.nvim_win_set_cursor(0, cursor_pos)
				vim.cmd("normal! zz")
			end,
		})
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
