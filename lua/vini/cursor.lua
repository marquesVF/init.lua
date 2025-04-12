local M = {}

local is_enabled = true

M.toggle = function()
  is_enabled = not is_enabled
  if is_enabled then
    require("cursor").setup(M.config)
    vim.notify("Cursor AI enabled", vim.log.levels.INFO)
  else
    require("cursor").stop()
    vim.notify("Cursor AI disabled", vim.log.levels.INFO)
  end
end

M.config = {
  -- API Configuration
  api_key = os.getenv("CURSOR_API_KEY"), -- Get this from your Cursor account
  model = "gpt-4", -- or "gpt-3.5-turbo"
  max_tokens = 1000,
  temperature = 0.7,

  -- UI Configuration
  ui = {
    border = "rounded",
    width = 0.8,
    height = 0.8,
  },

  -- Keybindings
  keymaps = {
    ask = "<leader>ca", -- Ask Cursor a question
    explain = "<leader>ce", -- Explain selected code
    refactor = "<leader>cr", -- Refactor selected code
    generate = "<leader>cg", -- Generate code
    toggle = "<leader>ct", -- Toggle Cursor AI
  },
}

M.setup = function()
  require("cursor").setup(M.config)
  
  -- Add toggle keybinding
  vim.keymap.set("n", M.config.keymaps.toggle, function()
    M.toggle()
  end, { desc = "Toggle Cursor AI" })
end

return M 