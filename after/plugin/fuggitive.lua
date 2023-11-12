vim.keymap.set("n", "<leader>gib", ":Git blame <CR>")
vim.keymap.set("n", "<leader>gid", ":Git diff <CR>")
vim.keymap.set("n", "<leader>gim", ":Git mergetool <CR>")

-- Enables :GBrowse
vim.api.nvim_create_user_command(
  'Browse',
  function (opts)
    vim.fn.system { 'open', opts.fargs[1] }
  end,
  { nargs = 1 }
)
