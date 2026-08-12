vim.schedule(function()
  vim.pack.add ({ 'https://github.com/aquibbaig/superfile.nvim' }, { load = function() end })
end)

local loaded = false

local function load_superfile()
  if loaded then return end
  loaded = true

  vim.cmd('packadd superfile.nvim')

  require('superfile').setup {
    command = 'spf',
    border = 'rounded',
    open_for_directories = false,
  }
end

vim.api.nvim_create_autocmd('CmdUndefined', {
  pattern = 'Superfile',
  callback = function()
    load_superfile()
    vim.schedule(function()
      vim.cmd 'Superfile'
    end)
  end,
})

vim.keymap.set('n', '<leader>y', function()
  load_superfile()
  require('superfile').toggle()
end, { desc = 'Toggle Superfile' })

vim.keymap.set('n', '<leader>Y', function()
  load_superfile()
  require('superfile').open(vim.fn.getcwd())
end, { desc = "Open Superfile in working directory" })
