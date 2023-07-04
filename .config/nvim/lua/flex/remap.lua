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

-- remove previous WORD without exiting insert mode
vim.keymap.set("i", "<C-h>", "<esc>bciW")

-- calculate and return result
-- vim.keymap.set("n", "<leader>r", ":s/ = .*//e<cr> \0y$ \\!!sed 's/mean/avg/;s/^/round(/;s/$/,3)/'<cr> \\!!calc -p<cr> \\Pa = <esc>hh")

vim.keymap.set("n", "<leader>i", ":VimwikiIndex<CR>")
vim.keymap.set("n", "<leader>k", ":EslintFixAll<CR>")
vim.keymap.set("x", "<leader>k", ":EslintFixAll<CR>")

-- supercollider synthdef to pbindef
vim.keymap.set("v", "<leader>p", ":s/\\\\/\\r\\\\/g | '<,'>s/^[^\\\\].*$//g | '<,'>s/).*/)/g | '<,'>s/\\(\\.[ak]r(\\)\\([^)]*\\))/, \\2,/ | '<,'>s/ \\(-[^,]*\\)/ (\\1)/ | '<,'>s/^\\(.*\\)\\(\\n\\1\\)\\+$/\\1/ | '<,'>s/\\v^\\s*\\n//g | '<s/\\([^{]*\\).*/(\\rPbindef(\\\\name,\\r\\\\instrument, \\1\\r\\\\dur, 1,/ | '>s/\\(.*\\)/\\1).play(quant: 1);\\r)/<CR>")

-- vim.keymap.set('n', '<leader>ps', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)

vim.keymap.set("n", "<leader>t", ":Telescope live_grep<CR>")

vim.api.nvim_set_keymap('i', '<C-j>', '<cmd>lua require("luasnip").jump(1)<Cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua require("luasnip").jump(-1)<Cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('s', '<C-j>', '<cmd>lua require("luasnip").jump(1)<Cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('s', '<C-k>', '<cmd>lua require("luasnip").jump(-1)<Cr>', {noremap = true, silent = true})

vim.keymap.set("n", "tt", ":tab split<CR>")
