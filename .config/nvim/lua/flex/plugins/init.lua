--  _                      ____  _             _
-- | |    __ _ _____   _  |  _ \| |_   _  __ _(_)_ __  ___
-- | |   / _` |_  / | | | | |_) | | | | |/ _` | | '_ \/ __|
-- | |__| (_| |/ /| |_| | |  __/| | |_| | (_| | | | | \__ \
-- |_____\__,_/___|\__, | |_|   |_|\__,_|\__, |_|_| |_|___/
--                 |___/                 |___/
--
--

return {
	{
		'christoomey/vim-tmux-navigator'
	},

	{
		dir = "/home/flex/.local/src/foxdot.vim",
		ft = "python",
		config = function()
			-- vim.keymap.set("n", "<CR>", ":FoxDotEval<CR>")
			vim.keymap.set("n", "<leader>.", ":FoxDotHush<CR>")
			vim.g.sclang_executable_path = '/usr/bin/sclang'
			vim.g.python_executable_path = '/usr/bin/python3'
		end
	},

	'xiyaowong/transparent.nvim',

	-- Git related plugins
	{
		'tpope/vim-fugitive',
		config = function()
			-- get the change from the left
			vim.keymap.set("n", "gh", ":diffget //2<CR>")
			-- get the change from the right
			vim.keymap.set("n", "gl", ":diffget //3<CR>")
			-- jump to next change and scroll to top
			vim.keymap.set("n", "gj", "]czt")
			-- jump to previous change and scroll to top
			vim.keymap.set("n", "gk", "[czt")
		end
	},
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
			{ 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

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
				vim.keymap.set({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
				vim.keymap.set({ 'n', 'v' }, '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
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
		-- branch = '0.1.x',
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

	-- { 'mellow-theme/mellow.nvim' },

	{
		'NvChad/nvim-colorizer.lua',
		config = function()
			require 'colorizer'.setup()
		end
	},

	{
		'tidalcycles/vim-tidal',
		config = function()
			vim.bo.commentstring = "-- %s"
			vim.g.tidal_target = "tmux"
			vim.g.tidal_no_mappings = 1
			vim.keymap.set("n", "<CR>", "<Plug>TidalParagraphSend")
			vim.keymap.set("n", "<leader>.", ":TidalHush<CR>")
			vim.keymap.set({ "n" }, "<C-h>", "<C-w>h") -- tidal cycles plugin overwrites this
		end
	},
	{
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
			vim.api.nvim_set_keymap("n", "<Leader>f", "<cmd>HopWord<CR>", { noremap = true })
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
	{
		'numToStr/Comment.nvim',
		opts = {
			ignore = '^$'
		},
		config = function()
			vim.api.nvim_set_keymap('n', '<leader>;', '<Plug>(comment_toggle_linewise_current)',
				{ noremap = false, silent = true })
			vim.api.nvim_set_keymap('x', '<leader>;', '<Plug>(comment_toggle_linewise_visual)',
				{ noremap = false, silent = true })
		end
	},

}
