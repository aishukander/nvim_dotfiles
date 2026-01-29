return{
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<c-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
      {
        '<leader>lg',
        function()
          if vim.fn.executable 'lazygit' ~= 1 then
            vim.schedule(function()
              vim.notify('lazygit not found. Please install it', vim.log.levels.ERROR)
            end)
            return
          end

          local git_path = vim.fs.find('.git', { upward = true })[1]
          
          if not git_path then
            vim.notify("Git repository not found!", vim.log.levels.WARN)
            return
          end

          local dir = vim.fs.dirname(git_path)
          local Terminal = require('toggleterm.terminal').Terminal
          local lazygit = Terminal:new { 
            cmd = 'lazygit', 
            hidden = true,
            dir = dir,
            direction = 'float',
            float_opts = {
              border = 'curved',
            },
          }
          lazygit:toggle()
        end,
        desc = 'LazyGit',
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