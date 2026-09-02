-- personal configs
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- moving between splits
vim.keymap.set("n", "<C-j>", "<C-W><C-j>", { desc = "Focus split below" })
vim.keymap.set("n", "<C-k>", "<C-W><C-k>", { desc = "Focus split above" })
vim.keymap.set("n", "<C-l>", "<C-W><C-l>", { desc = "Focus split right" })
vim.keymap.set("n", "<C-h>", "<C-W><C-h>", { desc = "Focus split left" })

-- all the following were defined by someone else on the internet
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- buffers
--vim.keymap.set("n", "<leader>q", ":bd<CR>")
vim.keymap.set("n", "<leader>ca", function()
    local abs_path = vim.api.nvim_buf_get_name(0)
    if abs_path == "" then return end
    vim.fn.setreg("+", abs_path)
    vim.notify("Copied absolute path: " .. abs_path, vim.log.levels.INFO)
end, { desc = "Copy absolute file path to clipboard" })
vim.keymap.set("n", "<leader>cp", function()
    local rel_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
    if rel_path == "" then return end
    vim.fn.setreg("+", rel_path)
    vim.notify("Copied relative path: " .. rel_path, vim.log.levels.INFO)
end, { desc = "Copy relative file path to clipboard" })
vim.keymap.set("n", "<leader>da", ':silent! execute "%bd|e#|bd#"<CR>', { desc = "Close all buffers except current" })
vim.keymap.set("n", "<leader>ls", ':ls<CR>', { desc = "List buffers" })
-- end buffers
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Reload configuration" })

-- Terminal shortcuts
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>", { desc = "Exit terminal mode" }) -- exit terminal-mode with ESC
vim.keymap.set('n', '<leader>nt', ":edit term://zsh <CR> i", { desc = "Open horizontal terminal" }) -- nt: new HORIZONTAL terminal entering insert mode
vim.keymap.set('n', '<leader>nvt', ":vsplit term://zsh <CR> i", { desc = "Open vertical terminal" }) -- nvt: new VERTICAL terminal entering insert mode

-- Move text up and down
vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv", { desc = "Move selection up" })

-- Resize panel
vim.keymap.set('n', '<leader>=', ":resize +5 <CR>", { desc = "Increase window height" }) -- nt: new terminal
vim.keymap.set('n', '<leader>-', ":resize -5 <CR>", { desc = "Decrease window height" }) -- nt: new terminal
