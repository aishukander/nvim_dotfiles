vim.schedule(function()
  vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  }, { load = function() end })
end)

local loaded = false

local function load_render_markdown()
  if loaded then return end
  loaded = true

  vim.cmd('packadd nvim-treesitter')
  vim.cmd('packadd mini.nvim')
  vim.cmd('packadd render-markdown.nvim')

  require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  once = true,
  callback = load_render_markdown,
})
