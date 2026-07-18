-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local api = require("nvim-tree.api")

local state_dir = vim.fn.stdpath("state")
local tree_width_file = state_dir .. "/nvim-tree-width"
local tree_state_file = state_dir .. "/nvim-tree-state"
local tree_resize_timer = nil

local function load_tree_width()
  local ok, lines = pcall(vim.fn.readfile, tree_width_file)
  if not ok or not lines or #lines == 0 then
    return nil
  end

  local width = tonumber(lines[1])
  if width and width > 0 then
    return width
  end
end

local function persist_tree_width(width)
  if not width or width <= 0 then
    return
  end

  vim.fn.mkdir(vim.fn.fnamemodify(tree_width_file, ":h"), "p")
  vim.fn.writefile({ tostring(width) }, tree_width_file)
end

local function load_tree_open_state()
  local ok, lines = pcall(vim.fn.readfile, tree_state_file)
  if not ok or not lines or #lines == 0 then
    return nil
  end

  return lines[1] == "open"
end

local function persist_tree_open_state(is_open)
  vim.fn.mkdir(vim.fn.fnamemodify(tree_state_file, ":h"), "p")
  vim.fn.writefile({ is_open and "open" or "closed" }, tree_state_file)
end

local function save_tree_size()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
    if bufname:match("NvimTree_") then
      local width = vim.api.nvim_win_get_width(win)
      vim.g.nvim_tree_width = width
      persist_tree_width(width)
      persist_tree_open_state(true)
      return
    end
  end

  persist_tree_open_state(false)
end

local function restore_tree_size()
  local width = vim.g.nvim_tree_width or load_tree_width()
  if api.tree.is_visible() and width then
    vim.cmd("vertical resize " .. width)
  end
end

local function schedule_save_tree_size()
  if tree_resize_timer then
    tree_resize_timer:stop()
    tree_resize_timer:close()
  end

  tree_resize_timer = vim.loop.new_timer()
  tree_resize_timer:start(150, 0, vim.schedule_wrap(function()
    save_tree_size()
    if tree_resize_timer then
      tree_resize_timer:close()
      tree_resize_timer = nil
    end
  end))
end

local function toggle_tree()
  if api.tree.is_visible() then
    save_tree_size()
  end
  api.tree.toggle()
  vim.schedule(restore_tree_size)
end

local function restore_tree_state()
  if load_tree_open_state() then
    vim.schedule(function()
      if not api.tree.is_visible() then
        api.tree.open()
      end
      restore_tree_size()
    end)
  end
end

vim.keymap.set("n", "<C-n>", toggle_tree, { desc = "Toggle nvim-tree (preserve size)" })
vim.keymap.set("n", "<leader>it", vim.cmd.NvimTreeFindFile, { desc = "Reveal file in nvim-tree" })

local function my_on_attach(bufnr)
  api.map.on_attach.default(bufnr)

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "l", api.node.open.edit, opts("Open: Edit"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
  on_attach = my_on_attach,
  view = {
    width = 35,
    preserve_window_proportions = true,
    side = "left",
    number = true,
    relativenumber = true,
  },
  filters = {
    git_ignored = false,
    dotfiles = false,
    custom = {
      "^node_modules$",
      "^dist$",
      "^build$",
      "^release$",
      "^target$",
      "^out$",
      "^coverage$",
      "^%.next$",
      "^%.turbo$",
    },
  },
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    restore_tree_state()
  end,
})

vim.api.nvim_create_autocmd({ "WinResized", "WinClosed" }, {
  callback = function()
    if api.tree.is_visible() then
      schedule_save_tree_size()
    else
      save_tree_size()
    end
  end,
})
