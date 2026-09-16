vim.schedule(function()
  vim.pack.add ({ 'https://github.com/akinsho/toggleterm.nvim' }, { load = function() end })
end)

local loaded = false
local terminal

local function load_toggleterm()
  if loaded then return end
  loaded = true

  vim.cmd('packadd toggleterm.nvim')

  require('toggleterm').setup {
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
  }
end

local function toggle_toggleterm_at_pwd()
  load_toggleterm()

  local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h')

  if dir == '' or vim.fn.isdirectory(dir) == 0 then
    dir = vim.fn.getcwd()
  end

  if terminal and terminal.dir ~= dir then
    terminal:shutdown()
    terminal = nil
  end

  if not terminal then
    local Terminal = require('toggleterm.terminal').Terminal
    terminal = Terminal:new {
      dir = dir,
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    }
  end

  terminal:toggle()
end

vim.keymap.set('n', '<leader>rt', toggle_toggleterm_at_pwd, { desc = 'Open Terminal' })
vim.keymap.set('n', '<c-\\>', toggle_toggleterm_at_pwd, { desc = 'Toggle Terminal' })
vim.keymap.set('t', '<c-\\>', function () terminal:toggle() end, { desc = 'Toggle Terminal' })

vim.keymap.set('n', '<leader>g', function()
  load_toggleterm()

  if vim.fn.executable 'lazygit' ~= 1 then
    vim.schedule(function()
      vim.notify('lazygit not found. Please install it', vim.log.levels.ERROR)
    end)
    return
  end

  local current_file = vim.api.nvim_buf_get_name(0)
  local search_path = current_file ~= "" and vim.fn.fnamemodify(current_file, ":p:h") or vim.fn.getcwd()

  local git_path = vim.fs.find('.git', { 
    upward = true, 
    path = search_path 
  })[1]

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
end, { desc = 'Open LazyGit' })
