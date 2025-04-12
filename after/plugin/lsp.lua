local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'cssls',
  'cucumber_language_server',
  'eslint',
  'jsonls',
  'lemminx',
  'lua_ls',
  'pyright',
  'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-i>"] = cmp.mapping.complete(),
  ['<C-n>'] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_next_item({ behavior = 'insert' })
    else
      cmp.complete()
    end
  end),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  select_behavior = 'insert'
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

--  This function gets run when an LSP connects to a particular buffer.
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>of", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  -- enable import key?: https://sharksforarms.dev/posts/neovim-rust/
  vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, {})

  -- format file when saving it
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.cmd("autocmd BufWritePre lua vim.lsp.buf.format()")
  end

  -- a fix so eslint recognize prettier configuration: https://github.com/neovim/neovim/issues/21254#issuecomment-1383262852
  --client.server_capabilities.documentFormattingProvider = true
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})

local luasnip = require('luasnip')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    -- use TAB to select autocomplete suggestion
    ['<TAB>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end
  }
})
