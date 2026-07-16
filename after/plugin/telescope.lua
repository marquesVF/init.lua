local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    path_display = { 'smart' },
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        width = 0.95,
        preview_width = 0.55,
      },
      vertical = {
        width = 0.95,
      },
    },
    preview = {
      treesitter = true,
    },
  },
})

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- Install the following dependency for grep search to work: https://github.com/BurntSushi/ripgrep#installation
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
