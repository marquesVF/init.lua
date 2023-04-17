local gotop = require('goto-preview')

vim.keymap.set("n", "<leader>gpd", gotop.goto_preview_definition, {})
vim.keymap.set("n", "<leader>gtd", gotop.goto_preview_type_definition, {})
vim.keymap.set("n", "<leader>gpi", gotop.goto_preview_implementation, {})
vim.keymap.set("n", "<leader>gpr", gotop.goto_preview_references, {})
vim.keymap.set("n", "<leader>qp", gotop.close_all_win, {})

