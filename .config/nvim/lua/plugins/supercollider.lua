return {
	"davidgranstrom/scnvim",
	-- dir = "~/.local/src/scnvim",
	ft = { "supercollider" },
	dependencies = {
		"davidgranstrom/scnvim-tmux",
		"madskjeldgaard/nvim-supercollider-piano",
		-- { "flexbusterman/nvim-supercollider-piano", dir = "~/.local/src/nvim-supercollider-piano/" },
	},
	config = function()
		local function adjust_tmux_height()
			local fixed_tmux_height = 10 -- Fixed height for the bottom tmux split
			vim.fn.system("tmux resize-pane -y " .. fixed_tmux_height .. " -t bottom")
		end

		-- Automatically adjust the tmux split height when Neovim is resized
		vim.api.nvim_create_autocmd("VimResized", {
			callback = adjust_tmux_height,
		})

		-- Set initial height at startup
		adjust_tmux_height()

		vim.o.wrap = true
		vim.o.linebreak = true
		-- vim.keymap.set("n", "j", "gj")
		-- vim.keymap.set("n", "k", "gk")
		-- vim.keymap.set("n", "h", "gh")
		-- vim.keymap.set("n", "l", "gl")
		-- vim.keymap.set("n", "0", "g0")
		-- vim.keymap.set("n", "$", "g$")

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
				horizontal = true,
				direction = "bot",
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
					size = "20%",
					-- cmd = "tail",
					-- args = { "-F", "$1" },
					cmd = "scnvim-tmux-post",
					args = { "$1" },
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
				-- ["<F1>"] = map_expr("s.boot"),
				-- ["<F2>"] = map_expr("s.meter"),
			},
		})

		scnvim.load_extension("tmux")

		vim.g.scnvim_snippet_format = "luasnip"

		-- vim.keymap.set("n", "<F1>", ":SCNvimExt piano.play 60<CR>", { desc = "Play midinote 60 with default synth" })
		vim.keymap.set("n", "<F1>", ":SCNvimExt piano.midi 48 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F2>", ":SCNvimExt piano.midi 49 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F3>", ":SCNvimExt piano.midi 50 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F4>", ":SCNvimExt piano.midi 51 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F5>", ":SCNvimExt piano.midi 52 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F6>", ":SCNvimExt piano.midi 53 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F7>", ":SCNvimExt piano.midi 54 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F8>", ":SCNvimExt piano.midi 55 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F9>", ":SCNvimExt piano.midi 56 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F10>", ":SCNvimExt piano.midi 57 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F11>", ":SCNvimExt piano.midi 58 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F12>", ":SCNvimExt piano.midi 59 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F13>", ":SCNvimExt piano.midi 60 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F14>", ":SCNvimExt piano.midi 61 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F15>", ":SCNvimExt piano.midi 62 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F16>", ":SCNvimExt piano.midi 63 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F17>", ":SCNvimExt piano.midi 64 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F18>", ":SCNvimExt piano.midi 65 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F19>", ":SCNvimExt piano.midi 66 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F20>", ":SCNvimExt piano.midi 67 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F21>", ":SCNvimExt piano.midi 68 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F22>", ":SCNvimExt piano.midi 69 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F23>", ":SCNvimExt piano.midi 70 0.5 8<CR>", { desc = "midinote duration channel" })
		vim.keymap.set("n", "<F24>", ":SCNvimExt piano.midi 71 0.5 8<CR>", { desc = "midinote duration channel" })

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

		-- vim.api.nvim_create_autocmd({
		-- 	"VimResized",
		-- }, {
		-- 	pattern = "scd",
		-- 	command = "exec 'vertical resize ' . string(&columns *  0.5)",
		-- })

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
