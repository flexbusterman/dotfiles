-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- use 'Mofiqul/dracula.nvim'
  use 'phaazon/hop.nvim'

  -- use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
  -- use('nvim-treesitter/playground')
	--
  -- use('theprimeagen/harpoon')
  -- use('mbbill/undotree')
	-- use('tpope/vim-fugitive')

  -- use('preservim/nerdcommenter')

  -- use('dstein64/vim-startuptime')

	use('leafoftree/vim-vue-plugin')

  -- use {
    -- 'nvim-lualine/lualine.nvim',
    -- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  -- }

  use {
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

  -- use('jose-elias-alvarez/null-ls.nvim')
  -- use('MunifTanjim/prettier.nvim')

  -- use {
    -- 'VonHeikemen/lsp-zero.nvim',
    -- requires = {
      -- -- LSP Support
      -- {'neovim/nvim-lspconfig'},
      -- {'williamboman/mason.nvim'},
      -- {'williamboman/mason-lspconfig.nvim'},

      -- -- Autocompletion
      -- {'hrsh7th/nvim-cmp'},
      -- {'hrsh7th/cmp-buffer'},
      -- {'hrsh7th/cmp-path'},
      -- {'saadparwaiz1/cmp_luasnip'},
      -- {'hrsh7th/cmp-nvim-lsp'},
      -- {'hrsh7th/cmp-nvim-lua'},

      -- -- Snippets
      -- {'L3MON4D3/LuaSnip'},
      -- -- {'rafamadriz/friendly-snippets'},
    -- }
  -- }

  -- use("folke/zen-mode.nvim")
	use("github/copilot.vim")

  use {
    'davidgranstrom/scnvim',
    config = function()
      require('scnvim').setup()
    end
  }

	use { 'davidgranstrom/scnvim-tmux' }

	use { 'christoomey/vim-titlecase' }

	use 'echasnovski/mini.nvim'
	require('mini.pairs').setup()
	require('mini.comment').setup(

		-- No need to copy this inside `setup()`. Will be used automatically.
		{
			-- Options which control module behavior
			options = {
				-- Whether to ignore blank lines when adding comment
				ignore_blank_line = false,
				-- Whether to recognize as comment only lines without indent
				start_of_line = false,
			},
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Toggle comment (like `gcip` - comment inner paragraph) for both
				-- Normal and Visual modes
				comment = 'gc',
				-- Toggle comment on current line
				comment_line = '<leader>;',
				-- Define 'comment' textobject (like `dgc` - delete whole comment block)
				textobject = 'gc',
			},
			-- Hook functions to be executed at certain stage of commenting
			hooks = {
				-- Before successful commenting. Does nothing by default.
				pre = function() end,
				-- After successful commenting. Does nothing by default.
				post = function() end,
			},
		}

	)
	require('mini.statusline').setup()

end)

