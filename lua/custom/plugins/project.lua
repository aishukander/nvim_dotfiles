local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.lsp.buf_get_clients = function(bufnr)
  return vim.lsp.get_clients { bufnr = bufnr }
end

local loaded = false

local function load_project()
  if loaded then return end
  loaded = true

  vim.pack.add { gh 'ahmedkhalf/project.nvim' }

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
