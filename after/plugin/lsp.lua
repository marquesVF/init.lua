-- Setup mason first
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    'cssls',
    'cucumber_language_server',
    'eslint',
    'jsonls',
    'lemminx',
    'lua_ls',
    'pyright',
    'rust_analyzer',
    'ts_ls'
  }
})

-- Initialize lspconfig to add configs to runtimepath
require('lspconfig')

-- Global LSP settings
vim.lsp.config('*', {
  flags = {
    debounce_text_changes = 150,
  },
})

-- Define on_attach function for keybindings
local on_attach = function(client, bufnr)
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

  -- TypeScript-specific keymaps
  if client.name == "ts_ls" then
    vim.keymap.set("n", "<leader>oi", function()
      vim.lsp.buf.execute_command({
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) }
      })
    end, opts)

    vim.keymap.set("n", "<leader>oa", function()
      vim.lsp.buf.execute_command({
        command = "_typescript.addMissingImports",
        arguments = { vim.api.nvim_buf_get_name(0) }
      })
    end, opts)
  end

  -- Git commands
  vim.keymap.set("n", "<leader>gdf", function()
    vim.cmd("Gvdiff")
  end, opts)

  -- a fix so eslint recognize prettier configuration: https://github.com/neovim/neovim/issues/21254#issuecomment-1383262852
  if client.supports_method("textDocument/formatting") then
    client.server_capabilities.documentFormattingProvider = true
  end

  -- Set up formatting command
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({
      filter = function(c)
        -- Use null-ls for TypeScript/TSX formatting
        if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
          return c.name == "null-ls"
        end
        -- Use default formatter for other file types
        return true
      end
    })
  end, opts)
end

-- Create LspAttach autocmd
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    on_attach(client, ev.buf)
  end,
})

-- Get capabilities from cmp_nvim_lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure individual servers
vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config('ts_ls', {
  capabilities = capabilities,
})

vim.lsp.config('eslint', {
  capabilities = capabilities,
})

vim.lsp.config('cssls', {
  capabilities = capabilities,
})

vim.lsp.config('jsonls', {
  capabilities = capabilities,
})

vim.lsp.config('pyright', {
  capabilities = capabilities,
})

vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
})

vim.lsp.config('lemminx', {
  capabilities = capabilities,
})

vim.lsp.config('cucumber_language_server', {
  capabilities = capabilities,
})

-- Enable all LSP servers
local servers = {
  'cssls',
  'cucumber_language_server',
  'eslint',
  'jsonls',
  'lemminx',
  'lua_ls',
  'pyright',
  'rust_analyzer',
  'ts_ls',
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- Set up diagnostic signs
local signs = { Error = 'E', Warn = 'W', Hint = 'H', Info = 'I' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Setup nvim-cmp
local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-i>'] = cmp.mapping.complete(),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({ behavior = 'insert' })
      else
        cmp.complete()
      end
    end),
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
  }),
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
