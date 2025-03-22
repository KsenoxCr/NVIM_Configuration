local map = vim.keymap.set
local del = vim.keymap.del

-- NOTE: Deleting 's' so leap.nvim can use it
-- del('n', 's')

-- NOTE: Remapping Substitute and replace line

map('n', 't', '<cmd>VimwikiToggleListItem<CR>', { noremap = true, silent = true })

-- NOTE: VimWiki

map('n', 't', '<cmd>VimwikiToggleListItem<CR>', { noremap = true, silent = true })
map('n', 'T', ':VimwikiTable ', { noremap = true })
map('n', 'H', '<cmd>VimwikiTableMoveColumnLeft<CR>', { noremap = true, silent = true })
map('n', 'L', '<cmd>VimwikiTableMoveColumnRight<CR>', { noremap = true, silent = true })
map('n', '<C-p>', require('custom.vimwiki-fn').AddPriorityTag, { desc = 'Add priority tag' })

-- [[ Basic Keymaps ]]
--  See `:help map()`
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

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

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

-- NOTE: Overriding nvim default keymaps

map('x', 'u', '<Nop>')
