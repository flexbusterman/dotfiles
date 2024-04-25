return {
	"davidgranstrom/scnvim",
	-- dir = "/home/flex/.local/src/scnvim/",
	ft = { "supercollider" },
	dependencies = {
		"davidgranstrom/scnvim-tmux",
	},
	config = function()
		local scnvim = require("scnvim")
		local map = scnvim.map
		local map_expr = scnvim.map_expr

		scnvim.setup({
			ensure_installed = true,
			sclang = {
				cmd = nil,
				args = {},
			},
			documentation = {
				cmd = "/usr/bin/pandoc",
				horizontal = false,
				direction = "right",
				keymaps = true,
			},
			editor = {
				force_ft_supercollider = true,
				highlight = {
					color = "TermCursor",
					type = "flash",
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
					name = "luasnip",
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
					size = "15%",
					cmd = "tail",
					args = { "-F", "$1" },
				},
				-- tmux = {
				--   path = vim.fn.tempname(),
				--   horizontal = true,
				--   size = '20%',
				--   cmd = 'scnvim-tmux',
				--   args = { '$1' },
				-- },
			},
			keymaps = {
				["<M-e>"] = map("editor.send_line", { "i", "n" }),
				["<CR>"] = {
					map("editor.send_block", "n"),
					map("editor.send_selection", "x"),
				},
				["<leader><CR>"] = map("postwin.toggle", "n"),
				["<M-CR>"] = map("postwin.toggle", "i"),
				["<leader>c"] = map("postwin.clear", "n"),
				["<K>"] = map("signature.show", "n"),
				["<leader>."] = map("sclang.hard_stop", { "n", "x" }),
				["<leader>s"] = map("sclang.start"),
				["<leader>sk"] = map("sclang.recompile"),
				["<F1>"] = map_expr("s.boot"),
				["<F2>"] = map_expr("s.meter"),
			},
		})

		scnvim.load_extension("tmux")

		vim.g.scnvim_snippet_format = "luasnip"

		-- vim.cmd([[
		-- augroup SuperColliderSnippets
		--     autocmd!
		--     autocmd FileType supercollider lua require("luasnip").add_snippets("supercollider", require("scnvim/utils").get_snippets())
		-- augroup END
		-- ]])
		vim.g.scnvim_snippets_loaded = false

		function load_scnvim_snippets()
			if not vim.g.scnvim_snippets_loaded then
				require("luasnip").add_snippets("supercollider", require("scnvim/utils").get_snippets())
				vim.g.scnvim_snippets_loaded = true
			end
		end

		vim.cmd([[
        augroup SuperColliderSnippets
            autocmd!
            autocmd FileType supercollider lua load_scnvim_snippets()
        augroup END
        ]])

		-- supercollider argument transformation

		vim.api.nvim_exec(
			[[
		function! ProcessRange() range
			" Substitution command
			'<,'>s/\(\\[^.]*\)\.[ka]r(\([^)]*\))/\r\1, \2,\r/g

			" Delete lines not starting with a backslash within the selection
			'<,'>g!/^\s*\\/d

			" Initialize the seen dictionary to track duplicates
			let seen = {}

			" Iterate over each line in the selection to remove duplicates
			let line_num = line("'<")
			while line_num <= line("'>")
				let line_content = getline(line_num)
				if has_key(seen, line_content)
					" If the line is a duplicate, delete it
					execute line_num . 'delete _'
				else
					" If the line is not a duplicate, add it to the seen dictionary
					let seen[line_content] = 1
					let line_num += 1
				endif
			endwhile

			" Wrap negative numbers in parentheses within the selection
			'<,'>s/\v-([0-9]+)/(-\1)/g
		endfunction
		]],
			false
		)

		vim.keymap.set("v", "<leader>p", ":'<,'>call ProcessRange()<CR>")
	end,
}
