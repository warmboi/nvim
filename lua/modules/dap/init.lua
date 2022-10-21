local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-D>', '<Cmd>lua require\'dapui\'.toggle()<CR>', opts)
map('n', '<F5>', '<Cmd>lua require\'dap\'.continue()<CR>', opts)
map('n', '<A-t>', '<Cmd>lua require\'dap\'.toggle_breakpoint()<CR>', opts)
map('n', '<F10>', '<Cmd>lua require\'dap\'.step_over()<CR>', opts)
map('n', '<F11>', '<Cmd>lua require\'dap\'.step_into()<CR>', opts)
map('n', '<Shift-F11>', '<Cmd>lua require\'dap\'.step_out()<CR>', opts)

local dap = require("dap");
dap.set_log_level("DEBUG");
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv("HOME") .. '/.config/nvim/external/node_debug/out/src/nodeDebug.js'},
}

dap.configurations.typescript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
	sourceMaps = true,
  },
  {
	type = 'pwa-node',
	request = 'attach',
	name = 'vscode-debug-attach',
	skipFiles = {"<node_internals>/**", "**/node_modules/**"},
	processId = require'dap.utils'.pick_process,
	cwd = "${workspaceFolder}"
  }
}
require('dap-vscode-js').setup({
  adapters = {
	'pwa-node', 'pwa-chrome'
  },
  debugger_path = os.getenv("HOME") .. '/.config/nvim/external/vscode_js_node_debug'

})
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        "breakpoints",
        { id = "scopes", size = 0.8 },
      },
      size = 40, -- 40 columns
      position = "left",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})
