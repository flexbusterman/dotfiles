-- https://sbulav.github.io/vim/neovim-setting-up-luasnip/
-- require("luasnip").add_snippets("all", "./snippets/all.snippets")
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/after/plugin/luasnippets/"})
