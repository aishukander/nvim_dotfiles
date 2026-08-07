local function gh(repo)
  return 'https://github.com/' .. repo
end

local loaded = false

local function load_dashboard()
  if loaded then return end
  loaded = true

  local startup_ms = 0
  if vim.g.startup_start_time then
    startup_ms = math.floor((vim.uv.hrtime() - vim.g.startup_start_time) / 1e6 + 0.5)
  end

  local loaded_plugins = 0
  for _, plugin in ipairs(vim.pack.get()) do
    if plugin.active then
      loaded_plugins = loaded_plugins + 1
    end
  end

  vim.pack.add { gh 'nvimdev/dashboard-nvim' }
  vim.pack.add { gh 'nvim-tree/nvim-web-devicons' }

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
          desc = 'New File                                  ',
          action = 'enew',
          key = 'a',
        },
        {
          icon = ' ',
          icon_hl = '@function',
          desc = 'Find Files                               ',
          action = 'Telescope find_files',
          key = 's',
        },
        {
          icon = ' ',
          icon_hl = '@number',
          desc = 'Recent Files                             ',
          action = 'Telescope oldfiles',
          key = 'r',
        },
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Superfile                                ',
          action = 'Superfile',
          key = 'f',
        },
        {
          icon = '󰊳 ',
          icon_hl = '@property',
          desc = 'Update                                   ',
          action = 'lua vim.pack.update()',
          key = 'u',
        },
        {
          icon = ' ',
          icon_hl = '@keyword',
          desc = 'Config                                   ',
          action = 'Telescope find_files cwd=' .. vim.fn.stdpath 'config',
          key = 'c',
        },
        {
          icon = ' ',
          icon_hl = '@error',
          desc = 'Quit                                     ',
          action = 'qa',
          key = 'q',
        },
      },
      footer = function()
        return {
          ('📦 %d/%d plugins loaded · ⚡ nvim loaded in %d ms'):format(
            loaded_plugins,
            #vim.pack.get(),
            startup_ms
          ),
        }
      end,
    },
  }
end

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = load_dashboard,
})
