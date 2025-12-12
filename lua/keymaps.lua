local map = vim.keymap.set

-- OS-agnostic

-- Set cursor incase neoscroll bug hides cursor

map('n', '<leader>Sc', function()
  vim.api.nvim_command ':set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
end, { desc = 'Set visible cursor' })

-- Copying messages into clipboard

map('n', '<leader>cm', function()
  local output = vim.api.nvim_exec2('messages', { output = true }).output
  vim.fn.setreg('+', output)
end, { desc = 'Copy :messages to clipboard' })

-- Inserting empty lines

map('n', 'm', 'o<Esc>', { noremap = true, silent = true })
map('n', 'M', 'O<Esc>', { noremap = true, silent = true })

-- Writing to file

map('n', '<C-s>', ':w<CR>', { desc = 'Write to file', noremap = true, silent = true })
map('n', '<C-S>', ':w!<CR>', { desc = 'Overwrite', noremap = true, silent = true })
map('n', '<C-A-s>', ':wall<CR>', { desc = 'Write all', noremap = true, silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>Q', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror message' })
map('n', 'fN', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', 'fn', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

-- Exit terminal mode

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.

map('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

-- Remapping visual-block mode

map('n', '<C-x>', '<C-v>', { desc = 'Visual-Block Mode' })
map('n', 'V', '<C-v>', { desc = 'Visual-Block Mode' })

-- Vim-visual-multiline

map('n', '<A-m>', '<Plug>(VM-Add-Cursor-Down)', { desc = '' })
map('n', '<A-,>', '<Plug>(VM-Add-Cursor-Up)', { desc = 'Add Cursor down' })

-- Disable Next occurence of selection

map('n', '<leader>s', '<Nop>')

-- Disable upper & lowercasing keymap for Visual-Block and Visual-Line modes

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

-- Fern file explorer

-- OS-agnostic

map('n', '<leader>er', function()
  vim.cmd('Fern ' .. vim.g.fsroot)
end, { noremap = true, silent = true, desc = 'Explorer ([R]oot)' })

map('n', '<leader>eh', function()
  vim.cmd('Fern ' .. (os.getenv 'HOME'))
end, { noremap = true, silent = true, desc = 'Explorer ([H]ome)' })

map('n', '<leader>ec', function()
  vim.cmd 'Fern %:h'
end, { noremap = true, silent = true, desc = 'Explorer ([C]WD)' })

map('n', '<leader>eW', function()
  vim.cmd('Fern ' .. vim.g.weeks)
end, { noremap = true, silent = true, desc = 'Explorer ([W]eek Plans)' })

map('n', '<leader>ep', function()
  vim.cmd('Fern ' .. vim.g.programming)
end, { noremap = true, silent = true, desc = 'Explorer ([P]rogramming)' })

map('n', '<leader>eP', function()
  vim.cmd('Fern ' .. vim.g.practice)
end, { noremap = true, silent = true, desc = 'Explorer ([P]ractice)' })

map('n', '<leader>eg', function()
  vim.cmd('Fern ' .. vim.g.wikidir)
end, { noremap = true, silent = true, desc = 'Explorer ([G]ods Plan)' })

map('n', '<leader>ea', function()
  vim.cmd('Fern ' .. vim.g.aiprompts)
end, { noremap = true, silent = true, desc = 'Explorer ([A]i Prompts)' })

map('n', '<leader>en', function()
  vim.cmd('Fern ' .. vim.fn.stdpath 'config' .. '/lua/plugins')
end, { noremap = true, silent = true, desc = 'Explorer ([N]eovim plugins)' })

map('n', '<leader>eD', function()
  vim.cmd('Fern ' .. vim.fn.stdpath 'data')
end, { noremap = true, silent = true, desc = 'Explorer (Neovim [D]ata files)' })

map('n', '<leader>es', function()
  vim.cmd('Fern ' .. vim.g.scripting)
end, { noremap = true, silent = true, desc = 'Explorer ([S]cripting)' })

map('n', '<leader>et', function()
  vim.cmd('Fern ' .. vim.g.templatepath)
end, { noremap = true, silent = true, desc = 'Explorer ([T]emplates)' })

map('n', '<leader>ed', function()
  vim.cmd('Fern ' .. vim.g.dotfiles)
end, { noremap = true, silent = true, desc = 'Explorer ([D]otfiles' })

map('n', '<leader>eb', function()
  vim.cmd('Fern ' .. vim.g.bash)
end, { noremap = true, silent = true, desc = 'Explorer ([B]ash Scripts)' })

-- Windows only

if os_name == 'Windows' then
  map('n', '<leader>eA', function()
    vim.cmd('Fern ' .. os.getenv 'LOCALAPPDATA')
  end, { noremap = true, silent = true, desc = 'Explorer (LOCAL[A]PPDATA)' })

  map('n', '<leader>eR', function()
    vim.cmd('Fern ' .. os.getenv 'APPDATA')
  end, { noremap = true, silent = true, desc = 'Explorer (APPDATA)' })
end

-- Template

map('n', '<leader>T', function()
  vim.api.nvim_feedkeys(':InsertTemplate ', 'n', true)
end, { desc = 'Insert [T]emplate (currentBuf)' })

-- TypeScript tools

map('n', '<leader>tfa', ':TSToolsFixAll<CR>', { desc = 'TS: Fix all fixable errors' })
map('n', '<leader>tia', ':TSToolsAddMissingImports<CR>', { desc = 'TS: Add missing imports' })
map('n', '<leader>tio', ':TSToolsOrganizeImports<CR>', { desc = 'TS: Organize imports' })
map('n', '<leader>tir', ':TSToolsRemoveUnusedImports<CR>', { desc = 'TS: Remove unused imports' })
map('n', '<leader>tr', ':TSToolsRemoveUnused<CR>', { desc = 'TS: Remove unused variables/imports' })
map('n', '<leader>tfr', ':TSToolsRenameFile<CR>', { desc = 'TS: Rename file' })
map('n', '<leader>tfR', ':TSToolsFileReferences<CR>', { desc = 'TS: Find file references' })

-- Opening common files

-- OS-agnostic

-- Windows only

if os_name == 'Windows' then
end

-- Linux only

if os_name == 'Linux' then
  local distro = vim.fn.system 'cat /etc/os-release'
  if distro:match 'Debian' then
    map('n', '<leader>fs', ':e ' .. vim.g.swayconf .. '<CR>', { desc = 'Open [S]way config' })
  elseif distro:match 'Arch' then
    map('n', '<leader>fh', ':e ' .. vim.g.hyprconf .. '<CR>', { desc = 'Open [H]yprland config' })
  end

  map('n', '<leader>fb', ':e ' .. vim.g.bashrc .. '<CR>', { desc = 'Open [B]ash config' })
  map('n', '<leader>fz', ':e ' .. vim.g.zshrc .. '<CR>', { desc = 'Open [Z]sh config' })
  map('n', '<leader>fk', ':e ' .. vim.g.kittyconf .. '<CR>', { desc = 'Open [K]itty config' })
  map('n', '<leader>fWc', ':e ' .. vim.g.waybarconf .. '<CR>', { desc = 'Open [C]onfig' })
  map('n', '<leader>fWs', ':e ' .. vim.g.waybarcss .. '<CR>', { desc = 'Open [S]tylesheet' })
end

map('n', '<leader>fc', ':e ' .. vim.g.claudeconf .. '<CR>', { desc = 'Open [C]laude config' })

map('n', '<leader>ft', ':e ' .. vim.g.tmuxconf .. '<CR>', { desc = 'Open [T]mux config' })

map('n', '<leader>fT', ':e ' .. vim.g.tmuxinator .. '<CR>', { desc = 'Open [T]muxinator config dir' })

-- Claude Code Terminal Window

map('n', '<leader>cs', ':ClaudePTerm --model sonnet<CR>', { desc = 'Claude Sonnet' })
map('n', '<leader>ch', ':ClaudePTerm --model haiku<CR>', { desc = 'Claude Haiku' })
map('n', '<leader>cS', ':ClaudePTerm --continue<CR>', { desc = 'Claude Continue' })

-- Telescope

map('n', '<leader>st', '<CMD>Telescope find_template<CR>', { desc = 'Telescope templates' })

-- LSP

map('n', '<leader>cr', vim.lsp.buf.rename, { noremap = true })
