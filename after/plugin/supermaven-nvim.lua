require("supermaven-nvim").setup({
    ignore_filetypes = { ".env" }
})

local api = require("supermaven-nvim.api")

vim.keymap.set("n", "<leader>sm", function()
  api.toggle()
  local status = api.is_running() and "enabled" or "disabled"
  print("Supermaven is now " .. status)
end, { desc = "Toggle Supermaven and show status" })

