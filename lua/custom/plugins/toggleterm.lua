local function gh(repo)
  return 'https://github.com/' .. repo
end

local loaded = false

local function load_toggleterm()
  if loaded then return end
  loaded = true

  vim.pack.add { gh 'akinsho/toggleterm.nvim' }

  require('toggleterm').setup {
    open_mapping = [[<c-\>]],
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
  }
end

vim.keymap.set('n', '<c-\\>', function()
  load_toggleterm()
  vim.cmd 'ToggleTerm'
end, { desc = 'Toggle Terminal' })

vim.keymap.set('n', '<leader>rt', function()
  load_toggleterm()
  vim.cmd 'ToggleTerm'
end, { desc = 'Open Terminal' })

vim.keymap.set('n', '<leader>lg', function()
  load_toggleterm()

  if vim.fn.executable 'lazygit' ~= 1 then
    vim.schedule(function()
      vim.notify('lazygit not found. Please install it', vim.log.levels.ERROR)
    end)
    return
  end

  local git_path = vim.fs.find('.git', { upward = true })[1]
  if not git_path then
    vim.notify('Git repository not found!', vim.log.levels.WARN)
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
end, { desc = 'LazyGit' })
