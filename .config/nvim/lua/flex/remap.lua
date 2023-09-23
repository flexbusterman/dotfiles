vim.g.mapleader = " "
vim.keymap.set("n", "<leader>h", vim.cmd.Ex)

-- vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever according to ThePrimeagen
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

-- vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set({"n"}, "<leader>j", "<nop>")
vim.keymap.set({"n"}, "<leader>j", vim.cmd.w)
vim.keymap.set({"n"}, "<leader>q", vim.cmd.q)
vim.keymap.set({"n"}, "<leader>Q", vim.cmd.x)
vim.keymap.set({"n"}, "<leader>d", "dd")

vim.keymap.set({"n"}, "<C-h>", "<C-w>h")
vim.keymap.set({"n"}, "<C-j>", "<C-w>j")
vim.keymap.set({"n"}, "<C-k>", "<C-w>k")
vim.keymap.set({"n"}, "<C-l>", "<C-w>l")

-- vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- title case
-- vim.keymap.set("n", "<leader>t", "<cmd>s/\\v<(.)(\\w*)/\\u\\1\\L\\2/g<CR>", { silent = true })
-- title case plugin
vim.keymap.set("n", "<leader>t", "<Plug>TitlecaseLine", { silent = true })
vim.keymap.set("v", "<leader>t", "<Plug>Titlecase", { silent = true })

-- no duplicate lines
vim.keymap.set("n", "<leader>l", ":g/^\\s\\+$/s/\\s\\+//e <CR> <bar> :silent! g/^$/,/./-j<CR><c-o>")

-- calculate and return result
-- vim.keymap.set("n", "<leader>r", ":s/ = .*//e<cr> \0y$ \\!!sed 's/mean/avg/;s/^/round(/;s/$/,3)/'<cr> \\!!calc -p<cr> \\Pa = <esc>hh")

vim.keymap.set("n", "<leader>k", ":EslintFixAll<CR>")
vim.keymap.set("x", "<leader>k", ":EslintFixAll<CR>")

-- supercollider synthdef to pbindef
-- vim.keymap.set("v", "<leader>p", ":s/\\\\/\\r\\\\/g | '<,'>s/^[^\\\\].*$//g | '<,'>s/).*/)/g | '<,'>s/\\(\\.[ak]r(\\)\\([^)]*\\))/, \\2,/ | '<,'>s/ \\(-[^,]*\\)/ (\\1)/ | '<,'>s/^\\(.*\\)\\(\\n\\1\\)\\+$/\\1/ | '<,'>s/\\v^\\s*\\n//g | '<s/\\([^{]*\\).*/(\\rPbindef(\\\\name,\\r\\\\instrument, \\1\\r\\\\dur, 1,/ | '>s/\\(.*\\)/\\1).play(quant: 1);\\r)/<CR>")

-- supercollider args to kr
vim.keymap.set("v", "<leader>p", ":s/\\(\\w*\\):\\(\\-*[0-9]*\\.*\\d*\\)/\\\\\\1.kr(\\2\\)/g<CR>")

-- vim.keymap.set('n', '<leader>ps', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)

vim.keymap.set("n", "<leader>t", ":Telescope live_grep<CR>")


-- set tab as jump to next snippet field for luasnip
vim.api.nvim_set_keymap('i', '<Tab>', 'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>"', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>"', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'luasnip#jumpable(-1) ? "<Plug>luasnip-jump-prev" : "<S-Tab>"', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'luasnip#jumpable(-1) ? "<Plug>luasnip-jump-prev" : "<S-Tab>"', {expr = true})

-- vim.api.nvim_set_keymap('i', '<C-j>', '<cmd>lua require("luasnip").jump(1)<Cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua require("luasnip").jump(-1)<Cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('s', '<C-j>', '<cmd>lua require("luasnip").jump(1)<Cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('s', '<C-k>', '<cmd>lua require("luasnip").jump(-1)<Cr>', {noremap = true, silent = true})

vim.keymap.set("n", "tt", ":tab split<CR>")

-- Smart Tag Jump function
_G.smart_tag_jump = function()
    local word = vim.fn.expand('<cword>')
    local taglist = vim.fn.taglist('^' .. word .. '$')
    if #taglist == 1 then
        vim.cmd('tag ' .. word)
    elseif #taglist > 1 then
        vim.cmd('tjump ' .. word)
    end
end
vim.keymap.set("n", "g]", "<cmd>lua _G.smart_tag_jump()<CR>")

-- vim.keymap.set("n", "<C-m>", ":lua require(\"harpoon.mark\").add_file()<CR>")

-- vimwiki
-- unbinding C-m
-- vim.g.vimwiki_key_mappings = {
--   all_maps = 1,
--   global = 1,
--   headers = 1,
--   text_objs = 1,
--   table_format = 1,
--   table_mappings = 1,
--   lists = 1,
--   links = 1,
--   html = 1,
--   mouse = 1,
-- }

vim.keymap.set("n", "<leader>i", ":VimwikiIndex<CR>")

vim.keymap.set("n", "<C-a>", ":lua require('harpoon.mark').add_file()<CR>")
vim.keymap.set("n", "<C-e>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
vim.keymap.set("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>")
vim.keymap.set("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>")
vim.keymap.set("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>")
vim.keymap.set("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>")
vim.keymap.set("n", "<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>")
vim.keymap.set("n", "<leader>6", ":lua require('harpoon.ui').nav_file(6)<CR>")
vim.keymap.set("n", "<leader>7", ":lua require('harpoon.ui').nav_file(7)<CR>")
vim.keymap.set("n", "<leader>8", ":lua require('harpoon.ui').nav_file(8)<CR>")
vim.keymap.set("n", "<leader>9", ":lua require('harpoon.ui').nav_file(9)<CR>")
