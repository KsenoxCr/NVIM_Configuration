local map = vim.keymap.set
local del = vim.keymap.del

-- TODO: Replace <leader>p (Lazy) with <leader>P

-- NOTE: Deleting 's' so leap.nvim can use it
-- del('n', 's')

-- NOTE: Deleting 'q' so surround can use it
-- map('n', 'q', '<Nop>', { desc = 'Disable macro recording' })

-- NOTE: Copy Current Buffer's File Into Temp Dir

vim.keymap.set('n', '<leader>cc', function()
  vim.api.nvim_command 'CopyCurrentFile'
end, { desc = 'Copy :messages to clipboard' })

-- NOTE: Copying messages into clipboard

vim.keymap.set('n', '<leader>cm', function()
  local output = vim.api.nvim_exec2('messages', { output = true }).output
  vim.fn.setreg('+', output)
end, { desc = 'Copy :messages to clipboard' })

-- NOTE: Inserting empty lines

map('n', 'm', 'o<Esc>', { noremap = true, silent = true })
map('n', 'M', 'O<Esc>', { noremap = true, silent = true })

-- NOTE: Writing to file
map('n', '<C-s>', ':w<CR>', { desc = 'Write to file', noremap = true, silent = true })
map('n', '<C-S>', ':w!<CR>', { desc = 'Overwrite', noremap = true, silent = true })
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

map('n', '<A-m>', '<Plug>(VM-Add-Cursor-Down)', { desc = '' })

map('n', '<A-,>', '<Plug>(VM-Add-Cursor-Up)', { desc = 'Add Cursor down' })

-- NOTE: Disable Next occurence of selection

map('n', '<leader>s', '<Nop>')

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

-- NOTE: Fern

map('n', '<leader>er', function()
  vim.cmd('Fern ' .. vim.g.root)
end, { noremap = true, silent = true, desc = 'Explorer ([R]oot)' })

map('n', '<leader>eh', function()
  vim.cmd('Fern ' .. (os.getenv 'HOME'))
end, { noremap = true, silent = true, desc = 'Explorer ([H]ome)' })

map('n', '<leader>ec', function()
  vim.cmd 'Fern %:h'
end, { noremap = true, silent = true, desc = 'Explorer ([C]WD)' })

map('n', '<leader>ew', function()
  vim.cmd('Fern ' .. vim.g.workpath)
end, { noremap = true, silent = true, desc = 'Explorer ([W]ork)' })

map('n', '<leader>eW', function()
  vim.cmd('Fern ' .. vim.g.weeks)
end, { noremap = true, silent = true, desc = 'Explorer ([W]eekPlans)' })

map('n', '<leader>ep', function()
  vim.cmd('Fern ' .. vim.g.posh)
end, { noremap = true, silent = true, desc = 'Explorer ([P]oSh)' })

map('n', '<leader>eP', function()
  vim.cmd('Fern ' .. vim.g.programming)
end, { noremap = true, silent = true, desc = 'Explorer ([P]rogramming)' })

map('n', '<leader>eg', function()
  vim.cmd('Fern ' .. vim.g.godsplan)
end, { noremap = true, silent = true, desc = 'Explorer ([G]ods Plan)' })

map('n', '<leader>ea', function()
  vim.cmd('Fern ' .. vim.g.ahkpath)
end, { noremap = true, silent = true, desc = 'Explorer ([A]utoHotKey)' })

map('n', '<leader>en', function()
  vim.cmd('Fern ' .. vim.fn.stdpath 'config' .. '/lua')
end, { noremap = true, silent = true, desc = 'Explorer ([N]eovim config files)' })

map('n', '<leader>ed', function()
  vim.cmd('Fern ' .. vim.g.dotnetpath)
end, { noremap = true, silent = true, desc = 'Explorer ([D]otnet Projects)' })

map('n', '<leader>eD', function()
  vim.cmd('Fern ' .. vim.fn.stdpath 'data')
end, { noremap = true, silent = true, desc = 'Explorer (Neovim [D]ata files)' })

map('n', '<leader>E', function()
  vim.cmd('Fern ' .. vim.g.workpath .. ' -reveal=%')
end, { noremap = true, silent = true, desc = 'Explorer (CWD)' })

map('n', '<leader>es', function()
  vim.cmd('Fern ' .. vim.g.school)
end, { noremap = true, silent = true, desc = 'Explorer ([S]chool Directory)' })

map('n', '<leader>eS', function()
  vim.cmd('Fern ' .. vim.g.scripting)
end, { noremap = true, silent = true, desc = 'Explorer ([S]ripting)' })

map('n', '<leader>et', function()
  vim.cmd('Fern ' .. vim.g.templatepath)
end, { noremap = true, silent = true, desc = 'Explorer ([T]emplates)' })

map('n', '<leader>ef', function()
  vim.cmd('Fern ' .. vim.g.profilepath)
end, { noremap = true, silent = true, desc = 'Explorer (Pro[f]iles)' })

map('n', '<leader>e8', function()
  vim.cmd('Fern ' .. vim.g.n8n)
end, { noremap = true, silent = true, desc = 'Explorer (n[8]n)' })

map('n', '<leader>eb', function()
  vim.cmd('Fern ' .. vim.g.bash)
end, { noremap = true, silent = true, desc = 'Explorer ([B]ash Scripts)' })

map('n', '<leader>eA', function()
  vim.cmd('Fern ' .. os.getenv 'LOCALAPPDATA')
end, { noremap = true, silent = true, desc = 'Explorer (LOCAL[A]PPDATA)' })

map('n', '<leader>eR', function()
  vim.cmd('Fern ' .. os.getenv 'APPDATA')
end, { noremap = true, silent = true, desc = 'Explorer (APPDATA)' })

map('n', '<leader>eC', function()
  vim.cmd('Fern ' .. 'C:\\')
end, { noremap = true, silent = true, desc = 'Explorer (C:\\)' })

-- NOTE: Template

map('n', '<leader>t', function()
  vim.api.nvim_feedkeys(':InsertTemplate ', 'n', true)
end, { desc = 'Insert [T]emplate (currentBuf)' })

-- NOTE: Opening common files

local os_name = jit.os

map('n', '<leader>fb', ':e ' .. vim.g.bashrc .. '<CR>', { desc = 'Open [B]ash config' })
map('n', '<leader>fh', ':e ' .. vim.g.hyprconf .. '<CR>', { desc = 'Open [H]yprland config' })
map('n', '<leader>fs', ':e ' .. vim.g.swayconf .. '<CR>', { desc = 'Open [S]way config' })
map('n', '<leader>fk', ':e ' .. vim.g.kittyconf .. '<CR>', { desc = 'Open [K]itty config' })
map('n', '<leader>ft', ':e ' .. vim.g.tech_problems .. '<CR>', { desc = 'Open [T]ech Problems' })
map('n', '<leader>fp', ':e ' .. vim.g.paths .. '<CR>', { desc = 'Open [P]aths' })
map('n', '<leader>fr', ':e ' .. vim.g.brain_ram .. '<CR>', { desc = 'Open Brain [R]AM' })
map('n', '<leader>fd', ':e ' .. vim.g.documents .. '<CR>', { desc = 'Open [D]ocumentations' })
map('n', '<leader>fw', function()
  vim.api.nvim_create_autocmd('BufEnter', {
    once = true,
    callback = function()
      vim.defer_fn(function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('G', true, false, true), 'n', true)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', true)
      end, 100)
    end,
  })

  vim.cmd('e ' .. vim.g.weeks)
end, { desc = 'Open Current Week (fern)' })
map('n', '<leader>fWc', ':e ' .. vim.g.waybarconf .. '<CR>', { desc = 'Open [C]onfig' })
map('n', '<leader>fWs', ':e ' .. vim.g.waybarcss .. '<CR>', { desc = 'Open [S]tylesheet' })

-- NOTE: Telescope

map('n', '<leader>st', '<CMD>Telescope find_template<CR>', { desc = 'Telescope templates' })

-- NOTE: VimWiki

-- FIX: Make these keymaps be prioritized over VimWiki internal mappings

-- map('n', '<leader>w<leader>m', '<Plug>(VimwikiTabMakeDiaryNote)', { desc = 'Remap TabMakeDiaryNote -> MakeTomorrowNote' })
-- map('n', '<leader>w<leader>t', '<Plug>(VimwikiMakeTomorrowDiaryNote)', { desc = 'Remap MakeTomorrowNote -> TabMakeDiaryNote' })
