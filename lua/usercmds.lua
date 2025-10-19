-- NOTE: Create Copy of Current Buffers file

vim.api.nvim_create_user_command('CopyCurrentFile', function()
  local cur_buf_path = vim.api.nvim_buf_get_name(0)

  if cur_buf_path == '' then
    print 'No buffer selected'
    return
  end

  local temp_dir = 'D:\\Temp\\nvim'

  local cmd = 'copy /Y ' .. cur_buf_path .. ' ' .. temp_dir

  vim.fn.system(cmd)
end, { desc = "Copy current buffer's file to temp dir" })

-- NOTE: Copy messages into clipboard

vim.api.nvim_create_user_command('ClipMessage', function()
  vim.cmd ':redir @+ | messages | redir END'
end, { desc = 'Copy messages to clipboard' })

-- NOTE: Insert Template into current buffer
vim.api.nvim_create_user_command('InsertTemplate', function(opts)
  vim.cmd(':read ' .. vim.g.templatepath .. '/' .. opts.args)
end, { nargs = 1, desc = 'Insert Template into current buffer' })

-- NOTE: Test <Plug> keymaps existence

vim.api.nvim_create_user_command('PlugMappingExists', function(opts)
  if vim.fn.maparg('<Plug>(' .. opts.args .. ')', 'n') ~= '' then
    print('✅ <Plug>(' .. opts.args .. ') exists')
  else
    print('❌ <Plug>(' .. opts.args .. ') not found')
  end
end, { nargs = 1, desc = 'Test wheter <Plug> exists or not' })

-- NOTE: Treesitter

vim.api.nvim_create_user_command('TSInstallInfoList', function()
  print(vim.inspect(require('nvim-treesitter.info').installed_parsers()))
end, { desc = 'Copy messages to clipboard' })

-- NOTE: DAP

vim.api.nvim_create_user_command('DapViewConfigs', function()
  print(vim.inspect(require('dap').configurations))
end, { desc = 'View DAP configurations' })

vim.api.nvim_create_user_command('DapViewAdapters', function()
  print(vim.inspect(require('dap').adapters))
end, { desc = 'View DAP adapters' })
