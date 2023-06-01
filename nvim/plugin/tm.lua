
require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = "/Users/tmartiro/tmp/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "node-terminal",
    request = "attach",
    name = "Attach",
    processId = require'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
  }
}
end

-- /Users/tmartiro/tmp/vscode-node-debug2

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


