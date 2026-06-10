local M = {}

function M.capabilities()
  return require("cmp_nvim_lsp").default_capabilities()
end

function M.on_attach(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local format_augroup = vim.api.nvim_create_augroup("ViniLspFormat", { clear = false })

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, opts)

  vim.keymap.set("n", "<leader>gr", function()
    require("telescope.builtin").lsp_references({
      layout_strategy = "vertical",
      layout_config = {
        width = 0.9,
        height = 0.9,
        preview_cutoff = 1,
        prompt_position = "top",
      },
      show_line = true,
    })
  end, opts)

  if client.name == "ts_ls" then
    vim.keymap.set("n", "<leader>oi", function()
      vim.lsp.buf.execute_command({
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
      })
    end, opts)

    vim.keymap.set("n", "<leader>oa", function()
      vim.lsp.buf.execute_command({
        command = "_typescript.addMissingImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
      })
    end, opts)
  end

  vim.keymap.set("n", "<leader>gdf", function()
    vim.cmd("Gvdiff")
  end, opts)

  vim.keymap.set("n", "<C-.>", function()
    vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end, opts)

  if client.supports_method("textDocument/formatting") then
    client.server_capabilities.documentFormattingProvider = true
  end

  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({
      filter = function(active_client)
        if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
          return active_client.name == "null-ls"
        end

        return true
      end,
    })
  end, opts)
end

return M
