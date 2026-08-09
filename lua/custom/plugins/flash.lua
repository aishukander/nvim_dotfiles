local flash_loaded = false

local function load_flash()
  if flash_loaded then return end
  flash_loaded = true

  vim.pack.add { 'https://github.com/folke/flash.nvim' }
  require('flash').setup({})
end

vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
  load_flash()
  require('flash').jump()
end, { desc = 'Run Flash' })

vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
  load_flash()
  require('flash').treesitter()
end, { desc = 'Run Flash Treesitter' })