-- [[ User Commands ]]

-- Claude in Pseudo Terminal

vim.api.nvim_create_user_command('ClaudePTerm', function(opts)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, { split = 'right', win = 0 })
  local cmd = 'claude ' .. opts.args
  vim.fn.termopen(cmd)
end, { nargs = '*', desc = 'Open Claude in pseudo terminal' })

vim.api.nvim_create_user_command('CodexPTerm', function(opts)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, { split = 'right', win = 0 })
  local cmd = 'codex' .. opts.args
  vim.fn.termopen(cmd)
end, { nargs = '*', desc = 'Open Claude in pseudo terminal' })

-- Copy messages into clipboard

vim.api.nvim_create_user_command('ClipMessage', function()
  vim.cmd ':redir @+ | messages | redir END'
end, { desc = 'Copy messages to clipboard' })

-- Insert Template into current buffer

vim.api.nvim_create_user_command('InsertTemplate', function(opts)
  vim.cmd(':read ' .. vim.g.templatepath .. '/' .. opts.args)
end, { nargs = 1, desc = 'Insert Template into current buffer' })

-- Test <Plug> keymaps existence

vim.api.nvim_create_user_command('PlugMappingExists', function(opts)
  if vim.fn.maparg('<Plug>(' .. opts.args .. ')', 'n') ~= '' then
    print('✅ <Plug>(' .. opts.args .. ') exists')
  else
    print('❌ <Plug>(' .. opts.args .. ') not found')
  end
end, { nargs = 1, desc = 'Test wheter <Plug> exists or not' })

-- Treesitter

vim.api.nvim_create_user_command('TSInstallInfoList', function()
  print(vim.inspect(require('nvim-treesitter.info').installed_parsers()))
end, { desc = 'List installed parsers' })

-- Debugger Adapter Protocol (DAP)

vim.api.nvim_create_user_command('DapViewConfigs', function()
  print(vim.inspect(require('dap').configurations))
end, { desc = 'View DAP configurations' })

vim.api.nvim_create_user_command('DapViewAdapters', function()
  print(vim.inspect(require('dap').adapters))
end, { desc = 'View DAP adapters' })
