local ls = require("luasnip.loaders.from_vscode")

ls.lazy_load()

ls.load({ include = { "typescript", "rust" } })

