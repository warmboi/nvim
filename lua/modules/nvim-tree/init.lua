require('nvim-tree').setup {
  open_on_setup = true,
  open_on_setup_file = true,
  git = {
	enable = true,
	ignore = false,
	show_on_dirs = true,
  },
  filters = {
	dotfiles = false,
	custom = {
	  "node_modules/*",
	  "dist/*",
	  "out/*",
	}
  }
}

