vim.schedule(function()
  vim.pack.add({
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/akinsho/bufferline.nvim',
  }, { load = function() end })
end)

local loaded = false

local function load_bufferline()
  if loaded then return end
  loaded = true

  vim.cmd('packadd mini.nvim')
  vim.cmd('packadd bufferline.nvim')

  require('bufferline').setup {
    options = {
      mode = 'buffers',
      separator_style = 'slant',
      diagnostics = 'nvim_lsp',
      numbers = 'buffer_id',
      show_buffer_close_icons = false,
      show_close_icon = false,
      always_show_bufferline = false,
    },
  }
end

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = load_bufferline,
})
