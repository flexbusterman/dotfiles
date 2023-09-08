vim.g.tidal_target = "tmux"
vim.g.tidal_no_mappings = 1

vim.keymap.set("n", "<CR>", "<Plug>TidalParagraphSend")
vim.keymap.set("n", "<leader>.", ":TidalHush<CR>")
