local loaded = false

local function load_render_markdown()
  if loaded then return end
  loaded = true

  vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
  vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }
  vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

  require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  once = true,
  callback = load_render_markdown,
})
