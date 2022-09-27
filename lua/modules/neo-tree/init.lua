local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<A-b>', '<Cmd>Neotree toggle<CR>', opts)

require('neo-tree').setup {
  window = {
	position = "left"
  },
  filesystem = {
	filtered_items = {
	  visible = true,
	  hide_hidden = true,
	  hide_gitignored = false,
	  hide_dotfiles = false,
	  never_show = {
		"node_modules"
	  }
	}
  }
}

