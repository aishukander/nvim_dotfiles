return{
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        mode = 'buffers',
        separator_style = 'slant', 
        diagnostics = 'nvim_lsp',
        numbers = "buffer_id",
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = false,
      },
    },
  },
}