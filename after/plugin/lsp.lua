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
  'tsserver',
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
  vim.keymap.set("n", "<leader>gr", function()
    require('telescope.builtin').lsp_references({
      layout_strategy = 'vertical',
      layout_config = {
        width = 0.9,
        height = 0.9,
        preview_cutoff = 1,
        prompt_position = "top",
      },
      show_line = true,
    })
  end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  -- enable import key?: https://sharksforarms.dev/posts/neovim-rust/
  vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, {})

  -- Git commands
  vim.keymap.set("n", "<leader>gdf", function()
    vim.cmd("Gvdiff")
  end, opts)

  -- Auto-import under cursor (similar to VS Code's Ctrl+. )
  vim.keymap.set("n", "<C-.>", function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.cmd("autocmd BufWritePre lua vim.lsp.buf.format()")
  end)

  -- a fix so eslint recognize prettier configuration: https://github.com/neovim/neovim/issues/21254#issuecomment-1383262852
  if client.supports_method("textDocument/formatting") then
    client.server_capabilities.documentFormattingProvider = true
  end

  -- Configure formatting for TypeScript files
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end

  -- Set up formatting command that uses Prettier for TypeScript
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({
      filter = function(client)
        -- Use Prettier for TypeScript files
        if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
          return client.name == "null-ls" -- Prettier runs through null-ls
        end
        -- Use default formatter for other file types
        return true
      end
    })
  end, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

local luasnip = require('luasnip')
local cmp = require('cmp')

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
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
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
      border = 'rounded',
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
      scrollbar = true,
      col_offset = -3,
      side_padding = 1,
    },
    documentation = {
      border = 'rounded',
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
    },
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      kind.kind = ' ' .. strings[1] .. ' '
      kind.menu = '    (' .. strings[2] .. ')'
      return kind
    end,
  },
})
