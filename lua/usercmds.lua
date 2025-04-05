-- NOTE: Open Fern in new pop up window (instead of current buffer)

-- local fern_popup = require 'custom.fern-popup'
--
-- vim.api.nvim_create_user_command('PopFern', fern_popup.popup, { desc = 'Open Fern in pop up window' })

-- NOTE: Insert Template into current buffer

vim.api.nvim_create_user_command('InsertTemplate', function(opts)
  vim.cmd(':read ' .. vim.g.global_templatepath .. '/' .. opts.args)
end, { nargs = 1, desc = 'Insert Template into current buffer' })

-- NOTE: Test <Plug> keymaps existence

vim.api.nvim_create_user_command('PlugMappingExists', function(opts)
  if vim.fn.maparg('<Plug>(' .. opts.args .. ')', 'n') ~= '' then
    print('✅ <Plug>(' .. opts.args .. ') exists')
  else
    print('❌ <Plug>(' .. opts.args .. ') not found')
  end
end, { nargs = 1, desc = 'Test wheter <Plug> exists or not' })
