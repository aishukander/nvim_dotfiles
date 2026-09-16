vim.schedule(function()
  vim.pack.add ({ 'https://github.com/akinsho/toggleterm.nvim' }, { load = function() end })
end)

local loaded = false
local buf_terminals = {}
local lazygit = nil

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

local function toggle_toggleterm_at_buf()
  load_toggleterm()

  local bufnr = vim.api.nvim_get_current_buf()
  local terminal = buf_terminals[bufnr]

  if not terminal then
    local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h')

    if dir == '' or vim.fn.isdirectory(dir) == 0 then
      dir = vim.fn.getcwd()
    end

    local Terminal = require('toggleterm.terminal').Terminal
    terminal = Terminal:new {
      dir = dir,
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    }
    buf_terminals[bufnr] = terminal
  end

  terminal:toggle()
end

vim.api.nvim_create_autocmd('BufWipeout', {
  group = vim.api.nvim_create_augroup('ToggleTermBufferClean', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    if buf_terminals[bufnr] then
      buf_terminals[bufnr]:shutdown()
      buf_terminals[bufnr] = nil
    end
  end,
})

vim.keymap.set('n', '<c-\\>', toggle_toggleterm_at_buf, { desc = 'Toggle Terminal' })
vim.keymap.set('t', '<c-\\>', function() vim.cmd('close') end, { desc = 'Toggle Terminal', silent = true })

vim.keymap.set('n', '<leader>g', function()
  load_toggleterm()

  if vim.fn.executable 'lazygit' ~= 1 then
    vim.notify('lazygit not found. Please install it', vim.log.levels.ERROR)
    return
  end

  if lazygit and lazygit:is_open() then
    lazygit:close()
    return
  end

  local current_file = vim.api.nvim_buf_get_name(0)
  local search_path = current_file ~= '' and vim.fn.fnamemodify(current_file, ':p:h') or vim.fn.getcwd()

  local git_path = vim.fs.find('.git', {
    upward = true,
    path = search_path,
  })[1]

  if not git_path then
    vim.notify('Git repository not found!', vim.log.levels.WARN)
    return
  end

  local dir = vim.fs.dirname(git_path)

  if not lazygit or lazygit.dir ~= dir then
    if lazygit then
      lazygit:shutdown()
    end

    local Terminal = require('toggleterm.terminal').Terminal
    lazygit = Terminal:new {
      cmd = 'lazygit',
      hidden = true,
      dir = dir,
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    }
  end

  lazygit:open()
end, { desc = 'Open LazyGit' })
