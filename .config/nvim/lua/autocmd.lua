local autocmd = vim.api.nvim_create_autocmd
local FlexGroup = vim.api.nvim_create_augroup('Flex', {})


function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd({
    "BufWritePre"
}, {
    group = FlexGroup,
    pattern = "*",
    callback = function()
        -- Save current cursor position
        local save_cursor = vim.api.nvim_win_get_cursor(0)
        -- Remove trailing whitespace from each line
        vim.cmd([[ %s/\s\+$//e ]])
        -- Remove trailing empty or whitespace-only lines
        vim.cmd([[ %s/\(\n\s*\)\+\%$//e ]])
        -- Restore cursor position
        vim.api.nvim_win_set_cursor(0, save_cursor)
    end
})

autocmd({ "BufWritePre" }, {
	group = FlexGroup,
	pattern = { '*.vue' },
	command = 'silent! EslintFixAll',
})

autocmd({ "VimResized" }, {
	group = FlexGroup,
	pattern = "*",
	command = "exec 'vertical resize ' . string(&columns *  0.5)",
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})
