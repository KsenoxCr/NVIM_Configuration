local map = vim.keymap.set
local del = vim.keymap.del

-- TODO: Replace <leader>p (Lazy) with <leader>P

-- NOTE: Deleting 's' so leap.nvim can use it
-- del('n', 's')

-- NOTE: Deleting 'q' so surround can use it
map('n', 'q', '<Nop>', { desc = 'Disable macro recording' })

-- NOTE: Inserting empty lines

map('n', 'm', 'o<Esc>', { noremap = true, silent = true })
map('n', 'M', 'O<Esc>', { noremap = true, silent = true })

-- NOTE: Writing to file
map('n', '<C-s>', ':w<CR>', { desc = 'Write to file', noremap = true, silent = true })
map('n', '<C-A-s>', ':wall<CR>', { desc = 'Write all', noremap = true, silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>Q', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror message' })
map('n', 'fN', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', 'fn', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping

-- or just use <C-\><C-n> to exit terminal mode
-- map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- del('n', '<C-h') -- Deleting fern action-leave -- Deleting fern action-leave

-- Keybinds to make split navigation easier.
--  See `:help wincmd` for a list of all window commands
--  Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

-- NOTE: Remapping visual-block mode

map('n', '<C-x>', '<C-v>', { desc = 'Visual-Block Mode' })
map('n', 'V', '<C-v>', { desc = 'Visual-Block Mode' })

-- NOTE: Vim-visual-multiline

map('n', '<A-m>', '<Plug>(VM-Add-Cursor-Down)', { desc = '' })              -- NOTE: Removed detrimental noremap = true

map('n', '<A-,>', '<Plug>(VM-Add-Cursor-Up)', { desc = 'Add Cursor down' }) -- NOTE: Removed detrimental noremap = true

-- NOTE: Disable upper & lowercasing keymap for Visual-Block and Visual-Line modes

map('x', 'u', function()
  local mode = vim.fn.mode()
  if mode == '\22' or mode == 'V' then
    return '<Nop>'
  else
    return 'u'
  end
end, { expr = true, desc = 'Selection to lowercase' })

map('x', 'U', function()
  local mode = vim.fn.mode()
  if mode == '\22' or mode == 'V' then
    return '<Nop>'
  else
    return 'U'
  end
end, { expr = true, desc = 'Selection to UPPERCASE' })

-- map('n', '.', '<Nop>')

-- NOTE: fern

map('n', '<leader>ec', function()
  vim.cmd 'Fern %:h'
end, { noremap = true, silent = true, desc = 'Explorer (CWD)' })

map('n', '<leader>ew', function()
  vim.cmd('Fern ' .. vim.g.workpath)
end, { noremap = true, silent = true, desc = 'Explorer (Work)' })

map('n', '<leader>ep', function()
  vim.cmd('Fern ' .. vim.g.poshmodulepath)
end, { noremap = true, silent = true, desc = 'Explorer (Posh Modules)' })

map('n', '<leader>eP', function()
  vim.cmd('Fern ' .. vim.g.profilepath)
end, { noremap = true, silent = true, desc = 'Explorer (Profiles)' })

map('n', '<leader>eg', function()
  vim.cmd('Fern ' .. vim.g.godsplan)
end, { noremap = true, silent = true, desc = 'Explorer (Gods Plan)' })

map('n', '<leader>ea', function()
  vim.cmd('Fern ' .. vim.g.ahkpath)
end, { noremap = true, silent = true, desc = 'Explorer (AutoHotKey)' })

map('n', '<leader>en', function()
  vim.cmd('Fern ' .. vim.fn.stdpath 'config' .. '/lua')
end, { noremap = true, silent = true, desc = 'Explorer (Neovim config files)' })

map('n', '<leader>ed', function()
  vim.cmd('Fern ' .. vim.g.dotnetpath)
end, { noremap = true, silent = true, desc = 'Explorer (Dotnet Projects)' })

map('n', '<leader>eD', function()
  vim.cmd('Fern ' .. vim.fn.stdpath 'data')
end, { noremap = true, silent = true, desc = 'Explorer (Neovim data files)' })

map('n', '<leader>E', function()
  vim.cmd('Fern ' .. vim.g.workpath .. ' -reveal=%')
end, { noremap = true, silent = true, desc = 'Explorer (CWD)' })

map('n', '<leader>es', function()
  vim.cmd('Fern ' .. vim.g.school)
end, { noremap = true, silent = true, desc = 'Explorer (School Directory)' })

map('n', '<leader>et', function()
  vim.cmd('Fern ' .. vim.g.templatepath)
end, { noremap = true, silent = true, desc = 'Explorer (Templates)' })

-- NOTE: Template

map('n', '<leader>T', function()
  vim.api.nvim_feedkeys(':InsertTemplate ', 'n', true)
end, { desc = 'Insert Template (currentBuf)' })

-- NOTE: Telescope

map('n', '<leader>st', '<CMD>Telescope find_template<CR>', { desc = 'Telescope templates' })

-- NOTE: VimWiki

-- FIX: Make these keymaps be prioritized over VimWiki internal mappings

-- map('n', '<leader>w<leader>m', '<Plug>(VimwikiTabMakeDiaryNote)', { desc = 'Remap TabMakeDiaryNote -> MakeTomorrowNote' })
-- map('n', '<leader>w<leader>t', '<Plug>(VimwikiMakeTomorrowDiaryNote)', { desc = 'Remap MakeTomorrowNote -> TabMakeDiaryNote' })
