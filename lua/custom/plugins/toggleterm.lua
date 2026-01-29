return{
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<c-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
      {
        '<leader>gg',
        function()
          local git_path = vim.fs.find('.git', { upward = true })[1]
          
          if not git_path then
            vim.notify("Git repository not found!", vim.log.levels.WARN)
            return
          end

          local dir = vim.fs.dirname(git_path)
          local Terminal = require('toggleterm.terminal').Terminal
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