return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- toggle nvim-tree

		-- global mappings
		vim.keymap.set("n", "<leader>h", ":NvimTreeToggle<CR>", {
			noremap = true,
		})

		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom local mappings
			vim.keymap.set("n", "<BS>", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "<CR>", api.tree.change_root_to_node, opts("CD"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
		end

		local tree = require("nvim-tree")

		local config = {
			on_attach = my_on_attach,
			hijack_directories = {
				enable = false,
			},
			filters = {
				custom = { ".git" },
				exclude = { ".gitignore", ".env" },
			},
			update_cwd = true,
			renderer = {
				add_trailing = false,
				group_empty = false,
				highlight_git = false,
				highlight_opened_files = "none",
				root_folder_modifier = ":t",
				indent_markers = {
					enable = false,
				},
			},
			diagnostics = {
				enable = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
					eject = true,
					resize_window = true,
					window_picker = {
						enable = true,
						picker = "default",
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
				ignore_list = {},
			},
			git = {
				enable = true,
				ignore = true,
				timeout = 500,
			},
			view = {
				width = 30,
				side = "left",
				number = true,
				relativenumber = true,
			},
		}

		tree.setup(config)
	end,
}
