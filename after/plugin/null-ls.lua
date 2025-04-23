local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        "markdown",
      },
      -- Use project's prettier config
      prefer_local = "node_modules/.bin",
    }),
  },
}) 