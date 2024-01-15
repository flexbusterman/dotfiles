return {
	'theprimeagen/harpoon',
	config = function()
		vim.keymap.set("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>")
		vim.keymap.set("n", "<leader>e", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
		vim.keymap.set("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>")
		vim.keymap.set("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>")
		vim.keymap.set("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>")
		vim.keymap.set("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>")
		vim.keymap.set("n", "<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>")
		vim.keymap.set("n", "<leader>6", ":lua require('harpoon.ui').nav_file(6)<CR>")
		vim.keymap.set("n", "<leader>7", ":lua require('harpoon.ui').nav_file(7)<CR>")
		vim.keymap.set("n", "<leader>8", ":lua require('harpoon.ui').nav_file(8)<CR>")
		vim.keymap.set("n", "<leader>9", ":lua require('harpoon.ui').nav_file(9)<CR>")
	end
}
