-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

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

-- Custom toggle function that preserves window size
local function toggle_tree()
  local tree = require('nvim-tree.view')
  if tree.is_visible() then
    save_tree_size()
  end
  vim.cmd.NvimTreeToggle()
  vim.schedule(function()
    restore_tree_size()
  end)
end

vim.keymap.set("n", "<C-n>", toggle_tree)
vim.keymap.set("n", "<leader>it", vim.cmd.NvimTreeFindFile)

-- more more options
local my_on_attach = function(bufnr)
  local api = require("nvim-tree.api")
  api.config.mappings.default_on_attach(bufnr)

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "l", api.node.open.edit, opts("Open: Edit"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts("Help"))
end

-- setup with updated options
require("nvim-tree").setup({
  on_attach = my_on_attach,
  view = {
    width = 35,
    preserve_window_proportions = true,
    side = "left",
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
    change_dir = {
      enable = true,
      global = false,
    },
    remove_file = {
      close_window = true,
    },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})

-- Create autocommands to handle window size
vim.api.nvim_create_autocmd({ "WinResized" }, {
  pattern = "NvimTree_*",
  callback = save_tree_size,
})

-- show line numbers in the tree
local tree = require('nvim-tree.view')
tree.View.winopts.relativenumber = true
