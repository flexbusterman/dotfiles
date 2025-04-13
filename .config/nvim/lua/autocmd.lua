--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = ".env*",
	command = "set filetype=sh.env",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = "*.org",
	command = "TableModeEnable",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = "*.md",
	command = "set linebreak | set ft=vimwiki",
})

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*.tex",
	command = "write",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = "*",
	callback = function()
		vim.cmd("set formatoptions-=cro")
		vim.cmd("setlocal formatoptions-=cro")
	end,
})

local FlexGroup = vim.api.nvim_create_augroup("Flex", {})

-- vim.api.nvim_create_autocmd({
-- 	"InsertLeave",
-- }, {
-- 	group = FlexGroup,
-- 	pattern = "*.php,*.css",
-- 	command = "write",
-- })

vim.api.nvim_create_autocmd({
	"VimResized",
}, {
	group = FlexGroup,
	pattern = "*",
	command = "exec 'vertical resize ' . string(&columns *  0.5)",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = ".env*",
	command = "set filetype=sh.env",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = "*",
	callback = function()
		vim.cmd("set formatoptions-=cro")
		vim.cmd("setlocal formatoptions-=cro")
	end,
})

vim.api.nvim_create_autocmd({
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

-- vim.api.nvim_create_autocmd({
-- 	"Autocompile",
-- }, {
-- 	group = FlexGroup,
-- 	pattern = "c",
-- 	command = "nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>",
-- })
