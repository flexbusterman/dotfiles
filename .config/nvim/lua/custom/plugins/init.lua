-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'theprimeagen/harpoon',
  'christoomey/vim-titlecase',
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.base16').setup {
        palette = {
          base00 = "#282936", -- background
          base01 = "#3a3c4e",
          base02 = "#4d4f68",
          base03 = "#626483",
          base04 = "#62d6e8",
          base05 = "#e9e9f4", -- foreground
          base06 = "#f1f2f8",
          base07 = "#f7f7fb",
          base08 = "#ea51b2",
          base09 = "#b45bcf",
          base0A = "#00f769",
          base0B = "#ebff87",
          base0C = "#a1efe4",
          base0D = "#62d6e8",
          base0E = "#b45bcf",
          base0F = "#00f769",
        },
        use_cterm = true,
      }
    end,
  },
  'xiyaowong/transparent.nvim',
  {
    'tidalcycles/vim-tidal',
    config = function()
      vim.cmd("setlocal commentstring=--\\ %s")
      vim.g.tidal_target = "tmux"
      vim.g.tidal_no_mappings = 1

      vim.keymap.set("n", "<CR>", "<Plug>TidalParagraphSend")
      vim.keymap.set("n", "<leader>.", ":TidalHush<CR>")

      -- tidal plugin overwrites this
      vim.keymap.set({"n"}, "<C-h>", "<C-w>h")

      -- vim.g.maplocalleader = " "
      -- vim.keymap.set("n", "<C-e>", ":TidalSend<CR>")
      -- require('tidal').setup{
      -- boot = {
      --   tidal = {
      --     file = vim.api.nvim_get_runtime_file("BootTidal.hs", false)[1],
      --     args = {},
      --   },
      --   sclang = {
      --     file = vim.api.nvim_get_runtime_file("BootSuperDirt.scd", false)[1],
      --     enabled = false,
      --   },
      --   split = 'v',
      -- },
      -- keymaps = {
      --   send_line = "<C-L>",
      --   send_node = "<Leader>s",
      --   send_visual = "<C-L>",
      --   hush = "<C-H>"
      -- }
      --
      -- }
    end
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
      vim.api.nvim_set_keymap("n", "<Leader>f", "<cmd>HopWord<CR>", {noremap=true})
    end
  },
  {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {
          path = '/home/flex/Dropbox/NOTES/',
          syntax = 'markdown',
          ext = '.md',
        }
      }
    end
  }
}
