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

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	use("nvim-treesitter/nvim-treesitter-context")

	-- use('nvim-treesitter/playground')
	--
	-- use('theprimeagen/harpoon')
	-- use('mbbill/undotree')
	-- use('tpope/vim-fugitive')

	-- use('preservim/nerdcommenter')

	-- use('dstein64/vim-startuptime')

	use('leafoftree/vim-vue-plugin')
	use('TristanCrawford/vim-eel2')

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

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

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},
			-- Completion source for tags recommended by scnvim wiki
			{'quangnguyen30192/cmp-nvim-tags'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}

	-- use('jose-elias-alvarez/null-ls.nvim')
	-- use('MunifTanjim/prettier.nvim')

	-- use("folke/zen-mode.nvim")
	--
	-- use("github/copilot.vim")

	use {
		'davidgranstrom/scnvim',
		config = function()
			require('scnvim').setup()
		end
	}

	-- use { 'madskjeldgaard/supercollider-h4x-nvim',
	-- 	config = function()
	-- 			require'supercollider-h4x'.setup()
	-- 	end,
	-- 	after = {'scnvim'},
	-- 	requires = {
	-- 		'davidgranstrom/scnvim'
	-- 	}
	-- }

	use { 'davidgranstrom/scnvim-tmux' }

	use {'tidalcycles/vim-tidal' }

	use { 'christoomey/vim-titlecase' }

	use 'echasnovski/mini.nvim'
	-- require('mini.pairs').setup()
	require('mini.comment').setup({ mappings = { comment_line = '<leader>;' } })
	-- require('mini.statusline').setup()

	require('mini.base16').setup({
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

			-- base00 = '#112641',
			-- base01 = '#3a475e',
			-- base02 = '#606b81',
			-- base03 = '#8691a7',
			-- base04 = '#d5dc81',
			-- base05 = '#e2e98f',
			-- base06 = '#eff69c',
			-- base07 = '#fcffaa',
			-- base08 = '#ffcfa0',
			-- base09 = '#cc7e46',
			-- base0A = '#46a436',
			-- base0B = '#9ff895',
			-- base0C = '#ca6ecf',
			-- base0D = '#42f7ff',
			-- base0E = '#ffc4ff',
			-- base0F = '#00a5c5',

		},
		use_cterm = true,
	})

	-- use 'xiyaowong/nvim-transparent'
	use 'xiyaowong/transparent.nvim'

-- use({
--   "jackMort/ChatGPT.nvim",
--     config = function()
--       require("chatgpt").setup()
--     end,
--     requires = {
--       "MunifTanjim/nui.nvim",
--       "nvim-lua/plenary.nvim",
--       "nvim-telescope/telescope.nvim"
--     }
-- })

use({
  "thmsmlr/gpt.nvim",
  config = function()
    require('gpt').setup({
      api_key = os.getenv("OPENAI_API_KEY")
    })
    opts = { silent = true, noremap = true }
    vim.keymap.set('v', '<C-g>r', require('gpt').replace, {
      silent = true,
      noremap = true,
      desc = "[G]pt [R]ewrite"
    })
    vim.keymap.set('v', '<C-g>p', require('gpt').visual_prompt, {
      silent = false,
      noremap = true,
      desc = "[G]pt [P]rompt"
    })
    vim.keymap.set('n', '<C-g>p', require('gpt').prompt, {
      silent = true,
      noremap = true,
      desc = "[G]pt [P]rompt"
    })
    vim.keymap.set('n', '<C-g>c', require('gpt').cancel, {
      silent = true,
      noremap = true,
      desc = "[G]pt [C]ancel"
    })
    vim.keymap.set('i', '<C-g>p', require('gpt').prompt, {
      silent = true,
      noremap = true,
      desc = "[G]pt [P]rompt"
    })
  end
})

end)
