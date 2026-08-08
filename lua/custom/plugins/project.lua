local loaded = false

local function load_project()
  if loaded then return end
  loaded = true

  vim.pack.add { 'https://github.com/ahmedkhalf/project.nvim' }

  require('project_nvim').setup {
    manual_mode = false,
    detection_methods = { 'lsp', 'pattern' },
    patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },
  }

  require('telescope').load_extension 'projects'
end

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = load_project,
})
