-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>it", vim.cmd.NvimTreeFindFile)

-- empty setup using defaults
require("nvim-tree").setup()


local tree = require('nvim-tree.view')

-- show line numbers in the tree
tree.View.winopts.relativenumber = true
-- don't resize the window when opening a file from the tree viewer
tree.View.preserve_window_proportions = true

