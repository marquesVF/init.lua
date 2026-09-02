local gotop = require('goto-preview')

vim.keymap.set("n", "<leader>gpd", gotop.goto_preview_definition, { desc = "Preview definition" })
vim.keymap.set("n", "<leader>gtd", gotop.goto_preview_type_definition, { desc = "Preview type definition" })
vim.keymap.set("n", "<leader>gpi", gotop.goto_preview_implementation, { desc = "Preview implementation" })
vim.keymap.set("n", "<leader>gpr", gotop.goto_preview_references, { desc = "Preview references" })
vim.keymap.set("n", "<leader>qp", gotop.close_all_win, { desc = "Close preview windows" })
