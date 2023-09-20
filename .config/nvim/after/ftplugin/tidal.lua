vim.cmd("setlocal commentstring=--\\ %s")
vim.g.tidal_target = "tmux"
vim.g.tidal_no_mappings = 1

vim.keymap.set("n", "<CR>", "<Plug>TidalParagraphSend")
vim.keymap.set("n", "<leader>.", ":TidalHush<CR>")

-- tidal plugin overwrites this
vim.keymap.set({"n"}, "<C-h>", "<C-w>h")

-- vim.g.maplocalleader = " "
-- vim.keymap.set("n", "<C-e>", ":TidalSend<CR>")
