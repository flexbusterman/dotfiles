vim.cmd([[
	nnoremap - :Explore<CR>
	autocmd FileType netrw setl bufhidden=delete
]])
vim.g.netrw_banner=1
vim.g.netrw_liststyle=0
vim.g.netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"

vim.api.nvim_create_autocmd('filetype', {
  pattern = 'netrw',
  desc = 'Better mappings for netrw',
  callback = function()
    local bind = function(lhs, rhs)
      vim.keymap.set('n', lhs, rhs, {remap = true, buffer = true})
    end

    bind('l', '<CR>')
		bind('H', 'u')
		bind('h', '-^')
		bind('l', '<CR>')
		bind('.', 'gh')
		bind('P', '<C-w>z')
		bind('L', '<CR>:Lexplore<CR>')
		bind('<Leader>dd', ':Lexplore<CR>')
		bind('<C-l>', '<C-w><C-l>')
		bind('<C-h>', '<C-w><C-h>')
  end
})

local M = {}

M.adjust_cursor = function()
    local line_content = vim.api.nvim_get_current_line()
    if line_content == "../" then
        vim.api.nvim_command('normal! j')
    end
end

return M
