-- Put your custom keymaps here.
-- This file is loaded automatically after startup, so it stays separate from init.lua.

-- Buffer management keymaps
vim.keymap.set('n', '<leader>bd', function()
  require('mini.bufremove').delete(0, false)
end, { desc = 'Delete Buffer' })

vim.keymap.set('n', '<leader>bD', function()
  require('mini.bufremove').delete(0, true)
end, { desc = 'Delete Buffer (Force)' })

vim.keymap.set('n', '<leader>bo', function()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf and vim.bo[buf].buflisted then
      require('mini.bufremove').delete(buf, false)
    end
  end
end, { desc = 'Delete Other Buffers' })

-- lsp keymaps
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'rename and applies across project' })