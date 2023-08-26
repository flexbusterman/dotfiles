-- Start by requiring the parser configs from nvim-treesitter
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

-- Then, proceed with the setup of the rest of the Treesitter modules
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "help", "javascript", "typescript", "lua", "supercollider" }, -- Add 'supercollider' here

  indent = {
    enable = true
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
-- require'nvim-treesitter.configs'.setup {
--   -- A list of parser names, or "all"
--   ensure_installed = { "help", "javascript", "typescript", "lua" },
--
-- 	indent = {
-- 		enable = true
-- 	},
--
--   -- Install parsers synchronously (only applied to `ensure_installed`)
--   sync_install = false,
--
--   -- Automatically install missing parsers when entering buffer
--   -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--   auto_install = true,
--
--   highlight = {
--     -- `false` will disable the whole extension
--     enable = true,
--
-- 		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- 		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
-- 		-- Using this option may slow down your editor, and you may see some duplicate highlights.
-- 		-- Instead of true it can also be a list of languages
-- 		additional_vim_regex_highlighting = false,
-- 	},
-- }
--
