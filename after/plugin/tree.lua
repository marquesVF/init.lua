-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Use the new public API
local api = require("nvim-tree.api")

-- Save and restore tree width
local function save_tree_size()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    if bufname:match("NvimTree_") then
      vim.g.nvim_tree_width = vim.api.nvim_win_get_width(win)
      return
    end
  end
end

-- Restore tree size
local function restore_tree_size()
  if api.tree.is_visible() and vim.g.nvim_tree_width then
    vim.cmd("vertical resize " .. vim.g.nvim_tree_width)
  end
end

-- Custom toggle that preserves window size
local function toggle_tree()
  if api.tree.is_visible() then
    save_tree_size()
  end
  api.tree.toggle()
  vim.schedule(restore_tree_size)
end

-- Keymaps
vim.keymap.set("n", "<C-n>", toggle_tree, { desc = "Toggle nvim-tree (preserve size)" })
vim.keymap.set("n", "<leader>it", vim.cmd.NvimTreeFindFile, { desc = "Reveal file in nvim-tree" })

-- Custom mappings when tree opens
local function my_on_attach(bufnr)
  api.config.mappings.default_on_attach(bufnr)

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "l", api.node.open.edit, opts("Open: Edit"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

-- Setup nvim-tree with updated config
require("nvim-tree").setup({
  on_attach = my_on_attach,
  view = {
    width = 35,
    preserve_window_proportions = true,
    side = "left",
    number = true,
    relativenumber = true,
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

-- Optional: preserve tree width on resize
vim.api.nvim_create_autocmd("WinResized", {
  pattern = "*",
  callback = save_tree_size,
})
