local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

local jdtls_cmd = vim.fn.exepath("jdtls")
if jdtls_cmd == "" then
  return
end

local lsp_utils = require("vini.lsp")
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

if not root_dir then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

jdtls.start_or_attach({
  cmd = { jdtls_cmd, "-data", workspace_dir },
  root_dir = root_dir,
  capabilities = lsp_utils.capabilities(),
  on_attach = lsp_utils.on_attach,
})
