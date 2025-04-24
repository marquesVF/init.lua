-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>it", vim.cmd.NvimTreeFindFile)

-- setup with defaults
require("nvim-tree").setup({
  view = {
    width = 40,
    preserve_window_proportions = true,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        -- Custom mappings can be added here
      },
    },
  },
  renderer = {
    full_name = false,
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "all",
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    },
  },
  actions = {
    open_file = {
      resize_window = false,
      window_picker = {
        enable = true,
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})

-- Function to save and restore window size
local function save_tree_size()
  local tree = require('nvim-tree.view')
  if tree.is_visible() then
    local width = vim.fn.winwidth(tree.get_winnr())
    vim.g.nvim_tree_width = width
  end
end

local function restore_tree_size()
  local tree = require('nvim-tree.view')
  if tree.is_visible() and vim.g.nvim_tree_width then
    vim.cmd('vertical resize ' .. vim.g.nvim_tree_width)
  end
end

-- Create autocommands to handle window size
vim.api.nvim_create_autocmd({ "WinResized" }, {
  pattern = "NvimTree_*",
  callback = save_tree_size,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "NvimTree_*",
  callback = restore_tree_size,
})

-- show line numbers in the tree
local tree = require('nvim-tree.view')
tree.View.winopts.relativenumber = true
