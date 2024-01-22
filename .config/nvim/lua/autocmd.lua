local autocmd = vim.api.nvim_create_autocmd
local FlexGroup = vim.api.nvim_create_augroup("Flex", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = ".env*",
	command = "set filetype=sh.env",
})

autocmd({
	"BufWritePre",
}, {
	group = FlexGroup,
	pattern = "*",
	callback = function()
		-- Save current cursor position
		local save_cursor = vim.api.nvim_win_get_cursor(0)
		-- https://vim.fandom.com/wiki/Remove_unwanted_empty_lines
		-- The following will delete all trailing whitespace from each line, then replace three or more consecutive line endings with two line endings (a single blank line)
		vim.cmd([[ %s/\s\+$//e]])
		vim.cmd([[ %s/\n\{3,}/\r\r/e]])
		-- Remove trailing empty lines from the document
		vim.cmd([[ %s/\(\n\s*\)\+\%$//e ]])
		-- Get the total number of lines in the current buffer
		local total_lines = vim.api.nvim_buf_line_count(0)
		-- Check if the saved cursor line is within the new buffer range
		if save_cursor[1] > total_lines then
			-- If not, set the cursor to the last line of the buffer
			save_cursor[1] = total_lines
		end
		-- Restore cursor position
		vim.api.nvim_win_set_cursor(0, save_cursor)
	end,
})

autocmd({ "VimResized" }, {
	group = FlexGroup,
	pattern = "*",
	command = "exec 'vertical resize ' . string(&columns *  0.5)",
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
