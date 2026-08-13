vim.pack.add({
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/rcarriga/nvim-notify',
  'https://github.com/folke/noice.nvim',
}, { load = function() end })

local function load_noice()
  vim.cmd('packadd nui.nvim')
  vim.cmd('packadd nvim-notify')
  vim.cmd('packadd noice.nvim')

  require('noice').setup {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
  }
end

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function() vim.schedule(load_noice) end,
})
