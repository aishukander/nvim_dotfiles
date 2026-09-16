vim.schedule(function()
  vim.pack.add ({ 'https://github.com/CRAG666/code_runner.nvim' }, { load = function() end })
end)

local loaded = false

local function load_code_runner()
  if loaded then return end
  loaded = true

  vim.cmd('packadd code_runner.nvim')

  require('code_runner').setup {
    mode = 'term',
    focus = true,
    startinsert = true,
    term = {
      position = 'bot',
      size = 8,
    },
    filetype = {
      c = [[
        cd $dir &&
        gcc *.c -o $fileNameWithoutExt &&
        ./$fileNameWithoutExt
      ]],
      cpp = [[
        cd $dir &&
        g++ *.cpp -o $fileNameWithoutExt &&
        ./$fileNameWithoutExt
      ]],
      python = [[
        cd $dir &&
        if [ -f .venv/bin/python ]; then
          python=".venv/bin/python"
        elif [ -f ../.venv/bin/python ]; then
          python="../.venv/bin/python"
        else
          python="python"
        fi

        "$python" -u '$fileName'
      ]],
      go = [[
        cd $dir &&
        go mod tidy &&
        go run .
      ]],
      rust = [[
        cd $dir &&
        cargo run
      ]],
      java = [[
        cd $dir &&
        javac $fileName &&
        java $fileNameWithoutExt
      ]],
      javascript = 'node',
      zig = 'zig run',
      ['objective-c'] = 'cd $dir && gcc -framework Cocoa $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt',
      php = 'php',
      perl = 'perl',
      ruby = 'ruby',
      lua = 'lua',
      typescript = 'ts-node',
    },
  }
end

local function run_code_runner(command)
  load_code_runner()
  vim.schedule(function()
    vim.cmd(command)
  end)
end

vim.api.nvim_create_autocmd('CmdUndefined', {
  pattern = 'RunCode',
  callback = function() run_code_runner 'RunCode' end,
})

vim.api.nvim_create_autocmd('CmdUndefined', {
  pattern = 'RunFile',
  callback = function() run_code_runner 'RunFile' end,
})

vim.api.nvim_create_autocmd('CmdUndefined', {
  pattern = 'RunProject',
  callback = function() run_code_runner 'RunProject' end,
})

vim.keymap.set('n', '<leader>rr', function()
  run_code_runner 'RunCode'
end, { desc = 'Run Code' })

vim.keymap.set('n', '<leader>rf', function()
  run_code_runner 'RunFile'
end, { desc = 'Run File' })

vim.keymap.set('n', '<leader>rp', function()
  run_code_runner 'RunProject'
end, { desc = 'Run Project' })
