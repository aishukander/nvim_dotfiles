local loaded = false

local function load_dashboard()
  if loaded then return end
  loaded = true

  vim.pack.add { 'https://github.com/nvimdev/dashboard-nvim' }
  vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

  vim.g.startup_ms = 0
  if vim.g.startup_start_time then
    vim.g.startup_ms = math.floor((vim.uv.hrtime() - vim.g.startup_start_time) / 1e6 + 0.5)
    vim.g.startup_start_time = nil
  end

  local packages = vim.pack.get()
  vim.g.plugins = #packages
  vim.g.loaded_plugins = 0
  for _, plugin in ipairs(packages) do
    if plugin.active then
      vim.g.loaded_plugins = vim.g.loaded_plugins + 1
    end
  end

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
            vim.g.loaded_plugins,
            vim.g.plugins,
            vim.g.startup_ms
          ),
        }
      end,
    },
  }
end

local function run_dashboard(command)
  load_dashboard()
  vim.schedule(function()
    vim.cmd(command)
  end)
end

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = load_dashboard,
})

vim.keymap.set('n', '<leader>H', function()
  run_dashboard 'Dashboard'
end, { desc = 'Return to Dashboard' })
