vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Enables long tree history 
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- highlight the current line
vim.opt.cursorline = true

-- yank to clipboard: handy when copying things from and to neovim
vim.opt.clipboard = "unnamedplus"

vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

local fold_group = vim.api.nvim_create_augroup("vini_folding", { clear = true })

local function set_fold_options()
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldlevelstart = 99

    if vim.bo.buftype ~= "" or vim.bo.filetype == "" then
        vim.opt_local.foldmethod = "manual"
        vim.opt_local.foldexpr = "0"
        return
    end

    local parser_ok, parser = pcall(vim.treesitter.get_parser, 0)
    if parser_ok and parser then
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        return
    end

    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldexpr = "0"
end

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    group = fold_group,
    callback = set_fold_options,
})
