vim.opt.clipboard = 'unnamedplus'

-- Lazy git
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = '' })
vim.keymap.set('n', '<leader>e', ':Explore<CR>', { desc = '' })
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { desc = '' })

vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'Format',
  pattern = "*.go",
})


