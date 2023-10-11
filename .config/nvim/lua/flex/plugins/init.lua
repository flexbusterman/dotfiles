return {

  'xiyaowong/transparent.nvim',

	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',

	require 'kickstart.plugins.autoformat',
	require 'kickstart.plugins.debug',

	-- Detect tabstop and shiftwidth automatically
	-- 'tpope/vim-sleuth',

	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
	},

	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},

	-- Useful plugin to show you pending keybinds.
	{ 'folke/which-key.nvim', opts = {} },
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

				-- don't override the built-in and fugitive keymaps
				local gs = package.loaded.gitsigns
				vim.keymap.set({'n', 'v'}, ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, {expr=true, buffer = bufnr, desc = "Jump to next hunk"})
				vim.keymap.set({'n', 'v'}, '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, {expr=true, buffer = bufnr, desc = "Jump to previous hunk"})
			end,
		},
	},

	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = 'dracula',
				component_separators = '|',
				section_separators = '',
			},
		},
	},

	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		main = "ibl",
		opts = {},
	},

	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
		},
	},

	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},

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
  {
    'tidalcycles/vim-tidal',
    config = function()
			vim.bo.commentstring = "-- %s"
      vim.g.tidal_target = "tmux"
      vim.g.tidal_no_mappings = 1
      vim.keymap.set("n", "<CR>", "<Plug>TidalParagraphSend")
      vim.keymap.set("n", "<leader>.", ":TidalHush<CR>")
      vim.keymap.set({"n"}, "<C-h>", "<C-w>h") -- tidal cycles plugin overwrites this
		end
	},
	{
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
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
	},
	{ 'numToStr/Comment.nvim',
		opts = {
			ignore = '^$'
		},
		config = function()
			vim.api.nvim_set_keymap('n', '<leader>;', '<Plug>(comment_toggle_linewise_current)', { noremap = false, silent = true })
			vim.api.nvim_set_keymap('x', '<leader>;', '<Plug>(comment_toggle_linewise_visual)', { noremap = false, silent = true })
		end
	},

}
