local loaded = false

local function load_bufferline()
  if loaded then return end
  loaded = true

  vim.pack.add { 'https://github.com/nvim-tree/nvim-web-devicons' }
  vim.pack.add { 'https://github.com/akinsho/bufferline.nvim' }

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
