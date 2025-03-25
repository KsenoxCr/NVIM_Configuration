-- Open Fern in new pop up window (instead of current buffer)

local fern_popup = require 'custom.fern-popup'

vim.api.nvim_create_user_command('PopFern', fern_popup.popup, { desc = 'Open Fern in pop up window' })
