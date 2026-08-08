local loaded = false

local function load_copilot()
  if loaded then return end
  loaded = true

  vim.pack.add { 'https://github.com/zbirenbaum/copilot.lua' }

  require('copilot').setup {
    filetypes = {
      text = false,
      ['.'] = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = '<M-l>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
    },
    panel = { enabled = false },
  }
end

vim.api.nvim_create_autocmd('InsertEnter', {
  once = true,
  callback = load_copilot,
})

vim.api.nvim_create_autocmd('CmdUndefined', {
  pattern = 'Copilot',
  callback = function()
    load_copilot()
    vim.schedule(function()
      vim.cmd 'Copilot'
    end)
  end,
})

vim.keymap.set('n', '<leader>cs', function()
  load_copilot()

  require('copilot.suggestion').toggle_auto_trigger()
  if vim.g.copilot_auto_trigger == nil then
    vim.g.copilot_auto_trigger = true
  end

  vim.g.copilot_auto_trigger = not vim.g.copilot_auto_trigger

  if vim.g.copilot_auto_trigger then
    vim.notify('Copilot Auto Trigger Enabled')
  else
    vim.notify('Copilot Auto Trigger Disabled')
  end
end, { desc = 'Toggle Copilot Auto Trigger' })
