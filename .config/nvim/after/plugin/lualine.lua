local function scstatus()
	if vim.bo.filetype == "supercollider" then
		stat = vim.fn["scnvim#statusline#server_status"]()
		-- stat = stat:gsub("%%", "♪")
		stat = stat:gsub("%%", "")
		return stat
	else
		return ""
	end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
	lualine_a = {'mode'},
	lualine_b = {'branch', 'diff', 'diagnostics'},
	-- lualine_c = {'filename'},
	lualine_c = {'filename', scstatus},
	-- lualine_x = {'encoding', 'fileformat', 'filetype'},
	lualine_x = {'filetype'},
	lualine_y = {'progress'},
	lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
