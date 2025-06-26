-- TypeScript file type detection
vim.filetype.add({
  extension = {
    ts = "typescript",
    tsx = "typescriptreact",
  },
})

-- TypeScript/TSX specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
    vim.opt.smartindent = true
  end,
})

