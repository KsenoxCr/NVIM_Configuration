-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`

local map = vim.keymap.set

-- NOTE: VimWiki

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'vimwiki',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-y>', '<cmd>VimwikiToggleListItem<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'T', ':VimwikiTable ', { noremap = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'H', '<cmd>VimwikiTableMoveColumnLeft<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'L', '<cmd>VimwikiTableMoveColumnRight<CR>', { noremap = true, silent = true })
    map('n', '<C-p>', require('custom.vimwiki-fn').AddTag, { buffer = 0, desc = 'Add priority tag' })
    map('n', '<C-c>', function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('i- [ ]<Esc>', true, false, true), 'n', false)
    end, { buffer = 0, desc = 'Insert checkbox' })
  end,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = { '*.md', '*.wiki' },
  callback = function()
    local keysequence = 'i## ' .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t') .. '<CR><CR><Esc>'
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keysequence, true, false, true), 'n', false)
  end,
})

-- NOTE: Fern

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fern',
  callback = function()
    -- Faster window navigation

    vim.api.nvim_buf_set_keymap(0, 'n', '<C-k>', '<C-w>k', { noremap = true, desc = 'Move focus to the top window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-j>', '<C-w>j', { noremap = true, desc = 'Move focus to the bottom window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-h>', '<C-w>h', { noremap = true, desc = 'Move focus to the left window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-l>', '<C-w>l', { noremap = true, desc = 'Move focus to the right window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<ESC>', '<cmd>close<CR>', { noremap = true, desc = 'Move focus to the right window' })

    -- Faster file navigation

    vim.api.nvim_buf_set_keymap(0, 'n', 's', '<Plug>(leap-forward-to)', { desc = 'Leap forward to' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'w', '<Plug>(fern-action-open-or-expand)', { desc = 'open or expand' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'e', '<Plug>(fern-action-collapse)', { desc = 'collapse' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'h', '<Plug>(fern-action-open-or-enter)', { desc = 'open or enter' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'f', '<Plug>(fern-action-leave)', { desc = 'leave' })

    -- FIX: Ghetto version of opening file outside of popup
    -- TODO: reform this so that it works with
    -- fern-action-open-or-enter && fern-action-open-or-enter

    -- vim.api.nvim_buf_set_keymap(0, 'n', 'g', require('custom.fern-popup').open, { desc = 'open file outside of fern popup' }) -- Doesn't cause delay due to require adding fern-popup into package.loaded

    -- NOTE: Fern Preview Window

    vim.api.nvim_buf_set_keymap(0, 'n', 'p', '<Plug>(fern-action-preview:toggle)', { desc = 'Toggle preview window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-p>', '<Plug>(fern-action-preview:auto:toggle)', { desc = 'Toggle auto preview window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-d>', '<Plug>(fern-action-preview:down:half)', { desc = 'Scroll down in preview window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-u>', '<Plug>(fern-action-preview:up:half)', { desc = 'Scroll up in preview window' })
  end,
})

vim.api.nvim_create_autocmd('BufNewfile', {
  pattern = '*.cs',
  callback = function()
    print ''
    vim.cmd 'Template default.cs'
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
