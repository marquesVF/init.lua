-- personal configs
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- moving between splits
vim.keymap.set("n", "<C-j>", "<C-W><C-j>")
vim.keymap.set("n", "<C-k>", "<C-W><C-k>")
vim.keymap.set("n", "<C-l>", "<C-W><C-l>")
vim.keymap.set("n", "<C-h>", "<C-W><C-h>")

-- all the following were defined by someone else on the internet
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- buffers
--vim.keymap.set("n", "<leader>q", ":bd<CR>")
vim.keymap.set("n", "<leader>da", ':silent! execute "%bd|e#|bd#"<CR>')
vim.keymap.set("n", "<leader>ls", ':ls<CR>')
-- end buffers
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Terminal shortcuts
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>") -- exit terminal-mode with ESC
vim.keymap.set('n', '<leader>nt', ":edit term://zsh <CR> i") -- nt: new HORIZONTAL terminal entering insert mode
vim.keymap.set('n', '<leader>nvt', ":vsplit term://zsh <CR> i") -- nvt: new VERTICAL terminal entering insert mode

-- Move text up and down
vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv", opts)

-- Resize panel
vim.keymap.set('n', '<leader>=', ":resize +5 <CR>") -- nt: new terminal
vim.keymap.set('n', '<leader>-', ":resize -5 <CR>") -- nt: new terminal

