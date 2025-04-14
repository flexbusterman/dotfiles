return {
	{
		"nvim-orgmode/orgmode",
		ft = { "org" },
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
				-- org_todo_keywords = { "TODO", "NEXT", "LEARN", "|", "DONE" },
				org_todo_keywords = { "TODO", "|", "DONE" },
				-- mappings = {
				-- 	agenda = {
				-- 		org_agenda_todo = false,
				-- 	},
				-- },
			})
			local function create_sub_header()
				-- Get the current cursor position
				local current_line = vim.fn.line(".")
				local total_lines = vim.fn.line("$")

				-- Search upwards for the first header line
				local header_line = nil
				local level = 0
				for i = current_line, 1, -1 do
					local line_content = vim.fn.getline(i)
					local stars = line_content:match("^(%*+)%s")
					if stars then
						header_line = i
						level = #stars
						break
					end
				end

				if not header_line then
					print("No header found above the current line")
					return
				end

				-- Find the last line of the current header block
				local end_of_block = header_line
				for i = header_line + 1, total_lines do
					local line_content = vim.fn.getline(i)
					if line_content:match("^%*+%s") then
						break
					end
					end_of_block = i
				end

				-- Insert the sub-header after the current block with a space after the asterisks
				local new_header = string.rep("*", level + 1) .. " "
				vim.fn.append(end_of_block, new_header)

				-- Move the cursor to the new sub-header line and enter insert mode
				vim.fn.cursor(end_of_block + 1, 1)
				vim.api.nvim_feedkeys("A", "n", true)
			end

			-- Bind the function to <leader>oiH
			vim.api.nvim_set_keymap("n", "<leader>oiH", "", {
				noremap = true,
				silent = true,
				callback = create_sub_header,
				desc = "Insert a sub-header below the current content block",
			})
		end,
	},
	{
		"nvim-orgmode/telescope-orgmode.nvim",
		event = "VeryLazy",
		ft = { "org" },
		dependencies = {
			"nvim-orgmode/orgmode",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("orgmode")

			-- Set up org-specific keybindings only in .org files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "org",
				callback = function()
					vim.keymap.set(
						"n",
						"<leader>r",
						require("telescope").extensions.orgmode.refile_heading,
						{ buffer = true }
					)
					vim.keymap.set(
						"n",
						"<leader>fh",
						require("telescope").extensions.orgmode.search_headings,
						{ buffer = true }
					)
					vim.keymap.set(
						"n",
						"<leader>li",
						require("telescope").extensions.orgmode.insert_link,
						{ buffer = true }
					)
				end,
			})
		end,
	},
}
