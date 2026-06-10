require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "cssls",
    "cucumber_language_server",
    "eslint",
    "jsonls",
    "lemminx",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "ts_ls",
  },
  automatic_enable = false,
})

local cmp = require("cmp")
local luasnip = require("luasnip")
local lsp_utils = require("vini.lsp")
local capabilities = lsp_utils.capabilities()

local cmp_mappings = {
  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  ["<C-i>"] = cmp.mapping.complete(),
  ["<C-n>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
    else
      cmp.complete()
    end
  end),
}

vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = lsp_utils.on_attach,
})

vim.lsp.config("ts_ls", {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  capabilities = capabilities,
  on_attach = lsp_utils.on_attach,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

for _, server in ipairs({
  "cssls",
  "cucumber_language_server",
  "eslint",
  "jsonls",
  "lemminx",
  "lua_ls",
  "pyright",
  "ts_ls",
}) do
  vim.lsp.enable(server)
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = vim.tbl_extend("force", cmp_mappings, {
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
      scrollbar = true,
      col_offset = -3,
      side_padding = 1,
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. strings[1] .. " "
      kind.menu = "    (" .. strings[2] .. ")"
      return kind
    end,
  },
})
