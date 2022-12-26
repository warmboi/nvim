local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<A-b>', '<Cmd>Neotree toggle<CR>', opts)

require('neo-tree').setup {
  source_selector = {
	winbar = false,
	statusline = false
  },
  window = {
	position = "left",
	mappings = {
	  ["/"] = "noop",
	  ["f"] = "filter_on_submit",
	  ["F"] = "fuzzy_finder_directory_on_submit"
	}
  },
  filesystem = {
	filtered_items = {
	  visible = false,
	  hide_gitignored = false,
	  hide_dotfiles = false,
	  hide_by_pattern = {
		"**/node_modules/**",
		"**/dist/**"
	  },
	  find_by_full_path_words = true
	},
	window = {
	  mappings = {
		["/"] = "noop",
		["f"] = "filter_on_submit",
		["F"] = "fuzzy_finder_directory_on_submit"
	  }
	}
  }
}

