local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<leader>,', ':BufferPrevious<CR>', vim.tbl_extend('force', opts, { desc = 'Previous buffer' }))
map('n', '<leader>.', ':BufferNext<CR>', vim.tbl_extend('force', opts, { desc = 'Next buffer' }))
-- Re-order to previous/next
map('n', '<leader><', ':BufferMovePrevious<CR>', vim.tbl_extend('force', opts, { desc = 'Move buffer left' }))
map('n', '<leader>>', ' :BufferMoveNext<CR>', vim.tbl_extend('force', opts, { desc = 'Move buffer right' }))
-- Goto buffer in position...
map('n', '<leader>1', ':BufferGoto 1<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 1' }))
map('n', '<leader>2', ':BufferGoto 2<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 2' }))
map('n', '<leader>3', ':BufferGoto 3<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 3' }))
map('n', '<leader>4', ':BufferGoto 4<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 4' }))
map('n', '<leader>5', ':BufferGoto 5<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 5' }))
map('n', '<leader>6', ':BufferGoto 6<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 6' }))
map('n', '<leader>7', ':BufferGoto 7<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 7' }))
map('n', '<leader>8', ':BufferGoto 8<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 8' }))
map('n', '<leader>9', ':BufferGoto 9<CR>', vim.tbl_extend('force', opts, { desc = 'Go to buffer 9' }))
map('n', '<leader>0', ':BufferLast<CR>', vim.tbl_extend('force', opts, { desc = 'Go to last buffer' }))
-- Close buffer
map('n', '<leader>c', ':BufferClose<CR>', vim.tbl_extend('force', opts, { desc = 'Close buffer' }))
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
--map('n', '<leader>', ':BufferPick<CR>', opts)
map('n', '<C-w><C-p>', ':BufferPick<CR>', vim.tbl_extend('force', opts, { desc = 'Pick buffer' }))
-- Sort automatically by...
map('n', '<leader>bb', ':BufferOrderByBufferNumber<CR>', vim.tbl_extend('force', opts, { desc = 'Sort buffers by number' }))
map('n', '<leader>bd', ':BufferOrderByDirectory<CR>', vim.tbl_extend('force', opts, { desc = 'Sort buffers by directory' }))
map('n', '<leader>bl', ':BufferOrderByLanguage<CR>', vim.tbl_extend('force', opts, { desc = 'Sort buffers by language' }))

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
