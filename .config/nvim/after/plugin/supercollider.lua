local scnvim = require 'scnvim'
local map = scnvim.map
local map_expr = scnvim.map_expr
scnvim.setup {
	ensure_installed = true,
	sclang = {
		cmd = nil,
		args = {},
	},
	documentation = {
		cmd = '/usr/bin/pandoc',
		horizontal = true,
		direction = 'top',
		keymaps = true,
	},
	postwin = {
		highlight = false,
		auto_toggle_error = true,
		scrollback = 5000,
		horizontal = true,
		direction = 'bot',
		size = 10,
		fixed_size = 10,
		keymaps = nil,
		float = {
			enabled = false,
			row = 99,
			col = function()
				return vim.o.columns
			end,
			width = 64,
			height = 14,
			config = {
				border = 'single',
			},
			callback = function(id)
				vim.api.nvim_win_set_option(id, 'winblend', 10)
			end,
		},
	},
	-- postwin = {
    -- highlight = true,
    -- auto_toggle_error = true,
    -- scrollback = 5000,
    -- horizontal = false,
    -- direction = 'right',
    -- size = nil,
    -- fixed_size = nil,
    -- keymaps = nil,
    -- float = {
      -- enabled = true,
      -- row = function()
        -- return vim.o.lines
      -- end,
      -- col = function()
        -- return vim.o.columns
      -- end,
      -- width = 44,
      -- height = 10,
      -- config = {
        -- border = 'single',
      -- },
      -- callback = function(id)
        -- vim.api.nvim_win_set_option(id, 'winblend', 30)
      -- end,
    -- },
  -- },
	editor = {
		force_ft_supercollider = true,
		highlight = {
			color = 'TermCursor',
			type = 'flash',
			flash = {
				duration = 30,
				repeats = 1,
			},
			fade = {
				duration = 30,
			},
		},
		signature = {
			float = true,
			auto = true,
		},
	},
	snippet = {
		engine = {
			name = 'luasnip',
			options = {
				descriptions = true,
			},
		},
	},
	statusline = {
		poll_interval = 1,
	},
	extensions = {
		tmux = {
			path = vim.fn.tempname(),
			horizontal = true,
			size = '20%',
			-- cmd = 'tail',
			-- args = { '-F', '$1' }
			cmd = 'scnvim-tmux',
			args = { '$1' },
		},
	},
	keymaps = {
		['<M-e>'] = map('editor.send_line', {'i', 'n'}),
		['<CR>'] = {
			map('editor.send_block', 'n'),
			map('editor.send_selection', 'x'),
		},
		['<leader><CR>'] = map('postwin.toggle', 'n'),
		['<M-CR>'] = map('postwin.toggle', 'i'),
		['<M-L>'] = map('postwin.clear', {'n', 'i'}),
		['<K>'] = map('signature.show', 'n'),
		['<leader>.'] = map('sclang.hard_stop', {'n', 'x'}),
		['<leader>s'] = map('sclang.start'),
		['<leader>sk'] = map('sclang.recompile'),
		['<F1>'] = map_expr('s.boot'),
		['<F2>'] = map_expr('s.meter'),
	},
}

scnvim.load_extension('tmux')

vim.g.scnvim_snippet_format = "luasnip"
require("luasnip").add_snippets("supercollider", require("scnvim/utils").get_snippets())
