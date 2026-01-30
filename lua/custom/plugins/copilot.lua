return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
    keys = {
      {
        '<leader>cs',
        function()
          require('copilot.suggestion').toggle_auto_trigger()
          if vim.g.copilot_auto_trigger == nil then
             vim.g.copilot_auto_trigger = true
          end
          vim.g.copilot_auto_trigger = not vim.g.copilot_auto_trigger
          
          if vim.g.copilot_auto_trigger then
             vim.notify 'Copilot Auto Trigger Enabled'
          else
             vim.notify 'Copilot Auto Trigger Disabled'
          end
        end,
        desc = 'Toggle Copilot Auto Trigger',
      },
    },
    config = function()
      require('copilot').setup {
        filetypes = {
          text = false,
          ['.'] = false,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = false, -- Handled by blink.cmp <Tab>
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        panel = { enabled = false },
      }
    end,
}
