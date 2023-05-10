local jester = require("jester")

jester.setup({
  path_to_jest_run = './node_modules/.bin/jest',
  path_to_jest_debug = './node_modules/.bin/jest',
})

vim.keymap.set("n", "<leader>aj", function() jester.run() end, {})
vim.keymap.set("n", "<leader>rj", function() jester.run_file() end, {})
vim.keymap.set("n", "<leader>dj", function() jester.debug() end, {})

