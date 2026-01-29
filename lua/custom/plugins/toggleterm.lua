return{
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<c-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
      {
        '<leader>gg',
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          local git_path = vim.fs.find('.git', { upward = true })[1]
          local dir = git_path and vim.fs.dirname(git_path) or nil

          local gitui = Terminal:new { 
            cmd = 'gitui', 
            hidden = true,
            dir = dir,
            direction = 'float',
            float_opts = {
              border = 'curved',
            },
          }
          gitui:toggle()
        end,
        desc = 'GitUI',
      },
    },
    opts = {
      open_mapping = [[<c-\>]],
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    },
  },
}