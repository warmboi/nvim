require('windows').setup()

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-+>', '<Cmd>WindowsMaximize<CR>', opts)
map('n', '<A-=>', '<Cmd>WindowsEqualize<CR>', opts)
map('n', '<A-W>', '<Cmd>WindowsToggleAutowidth<CR>', opts)

