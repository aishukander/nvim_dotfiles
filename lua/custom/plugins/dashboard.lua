return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    theme = 'doom',
    config = function()
      require('dashboard').setup {
        theme = 'doom',
        config = {
          header = {
            '',
            ' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
            ' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
            ' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
            ' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
            ' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
            ' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
            '',
          },
          center = {
            {
              icon = ' ',
              icon_hl = '@type',
              desc = 'New File                          ',
              action = 'enew',
              key = 'a',
            },
            {
              icon = ' ',
              icon_hl = '@number',
              desc = 'Recent Files                      ',
              action = 'Telescope oldfiles',
              key = 'r',
            },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Yazi                              ',
              action = 'Yazi',
              key = 'f',
            },
            {
              icon = ' ',
              icon_hl = '@string',
              desc = 'Projects                          ',
              action = 'Telescope projects',
              key = 'p',
            },
            {
              icon = '󰊳 ',
              icon_hl = '@property',
              desc = 'Update                            ',
              action = 'Lazy update',
              key = 'u',
            },
            {
              icon = ' ',
              icon_hl = '@keyword',
              desc = 'Config                            ',
              action = 'Telescope find_files cwd=' .. vim.fn.stdpath 'config',
              key = 'c',
            },
            {
              icon = ' ',
              icon_hl = '@error',
              desc = 'Quit                              ',
              action = 'qa',
              key = 'q',
            },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '', '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}
