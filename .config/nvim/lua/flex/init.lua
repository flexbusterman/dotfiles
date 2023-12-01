require("flex.set")
require("flex.remap")
require("flex.netrw")
require("flex.plugins")

local augroup = vim.api.nvim_create_augroup
local FlexGroup = augroup('Flex', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = FlexGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd({ "BufWritePre" }, {
	group = FlexGroup,
	pattern = { '*.vue' },
	command = 'silent! EslintFixAll',
})

-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25

autocmd({ "VimResized" }, {
	group = FlexGroup,
	pattern = "*",
	command = "exec 'vertical resize ' . string(&columns *  0.5)",
})
