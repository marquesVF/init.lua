local rt = require("rust-tools")

rt.setup()

rt.runnables.runnables()

-- Rust runnables
vim.keymap.set("n", "<leader>rr", ":RustRunnables <CR>")

