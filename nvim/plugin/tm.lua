vim.opt.clipboard = 'unnamedplus'

-- Lazy git
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = '' })
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { desc = '' })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Close the current buffer' })
vim.keymap.set('n', '<leader>bd!', ':bd!<CR>', { desc = 'Force close the current buffer' })
vim.keymap.set('n', '<leader><Left>', ':bprevious<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<leader><Right>', ':bnext<CR>', { desc = 'Switch to next buffer' })
vim.keymap.set('n', '<leader>bd!', ':bd!<CR>', { desc = 'Force close the current buffer' })

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*.go',
--   callback = function()
--     vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
--   end
-- })



vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'Format',
  pattern = "*.go",
})


