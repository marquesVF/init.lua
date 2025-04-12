local M = {}

M.setup = function()
  require("cursor").setup({
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
    },
  })
end

return M 