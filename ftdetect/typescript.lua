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
  callback = function(event)
    vim.bo[event.buf].tabstop = 2
    vim.bo[event.buf].softtabstop = 2
    vim.bo[event.buf].shiftwidth = 2
    vim.bo[event.buf].expandtab = true
    vim.bo[event.buf].smartindent = true
  end,
})
