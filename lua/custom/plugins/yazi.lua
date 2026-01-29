return {
  'mikavilpas/yazi.nvim',
  keys = {
    {
      '<leader>y',
      '<cmd>Yazi<cr>',
      desc = 'Open Yazi',
    },
    {
      '<leader>Y',
      '<cmd>Yazi cwd<cr>',
      desc = "Open the Yazi in nvim's working directory",
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
  },
  config = function(_, opts)
    if vim.fn.executable('yazi') == 1 then
      require('yazi').setup(opts)
    else
      vim.schedule(function()
        vim.notify('Yazi not found! Please install it', vim.log.levels.WARN)
      end)
    end
  end,
}
