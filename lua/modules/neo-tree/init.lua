require('neo-tree').setup {
  filesystem = {
	filtered_items = {
	  hide_dotfiles = false,
	  hide_gitignored = false,
	  never_show = {
		".DS_Store",
		".git"
	  }
	}
  }
}

