vim.keymap.set("n", "<leader>gib", ":Git blame <CR>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>gid", ":Git diff <CR>", { desc = "Git diff" })
vim.keymap.set("n", "<leader>gim", ":Git mergetool <CR>", { desc = "Git mergetool" })

-- Enables :GBrowse
vim.api.nvim_create_user_command(
  'Browse',
  function (opts)
    vim.fn.system { 'open', opts.fargs[1] }
  end,
  { nargs = 1 }
)
