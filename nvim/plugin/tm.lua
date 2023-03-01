vim.opt.clipboard = 'unnamedplus'

-- Lazy git
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = '' })
vim.keymap.set('n', '<leader>e', ':Explore<CR>', { desc = '' })
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { desc = '' })

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})

vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'Format',
  pattern = "*.go",
})


