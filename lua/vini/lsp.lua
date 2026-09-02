local M = {}

function M.capabilities()
  return require("cmp_nvim_lsp").default_capabilities()
end

function M.on_attach(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
  end
  local format_augroup = vim.api.nvim_create_augroup("ViniLspFormat", { clear = false })

  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "K", vim.lsp.buf.hover, "Hover documentation")
  map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
  map("n", "<leader>of", vim.diagnostic.open_float, "Show diagnostic")
  map("n", "[d", vim.diagnostic.goto_next, "Next diagnostic")
  map("n", "]d", vim.diagnostic.goto_prev, "Previous diagnostic")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
  map("n", "<leader>ga", vim.lsp.buf.code_action, "Code action")

  map("n", "<leader>gr", function()
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
  end, "Find references")

  if client.name == "ts_ls" then
    map("n", "<leader>oi", function()
      vim.lsp.buf.execute_command({
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
      })
    end, "Organize imports")

    map("n", "<leader>oa", function()
      vim.lsp.buf.execute_command({
        command = "_typescript.addMissingImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
      })
    end, "Add missing imports")
  end

  map("n", "<leader>gdf", function()
    vim.cmd("Gvdiff")
  end, "Diff against index")

  map("n", "<C-.>", function()
    vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end, "Format buffer on save")

  if client.supports_method("textDocument/formatting") then
    client.server_capabilities.documentFormattingProvider = true
  end

  map("n", "<leader>f", function()
    vim.lsp.buf.format({
      filter = function(active_client)
        if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
          return active_client.name == "null-ls"
        end

        return true
      end,
    })
  end, "Format buffer (LSP)")
end

return M
