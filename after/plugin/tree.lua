-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>it", vim.cmd.NvimTreeFindFile)

-- empty setup using defaults
require("nvim-tree").setup()


-- show line numbers in the tree
require'nvim-tree.view'.View.winopts.relativenumber = true
