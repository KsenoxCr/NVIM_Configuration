-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- local lspconfig = require 'lspconfig'
-- local configs = require 'lspconfig.configs'
--
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'zsh',
--   callback = function(args)
--     -- start/attach bashls for this buffer
--     lspconfig.bashls.manager.try_add_wrapper(args.buf)
--   end,
-- })

local map = vim.keymap.set

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'ps1', 'psm1', 'psd1' },
  callback = function()
    vim.keymap.set('n', '<leader>P', function()
      require('powershell').toggle_term()
    end, { buffer = 0, desc = 'Toggle Powershell terminal' })

    vim.keymap.set({ 'n', 'x' }, '<leader>R', function()
      require('powershell').eval()
    end, { buffer = 0, desc = 'Evaluate posh expression in terminal' })
  end,
})

-- NOTE: VimWiki

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'vimwiki',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-y>', '<cmd>VimwikiToggleListItem<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'T', ':VimwikiTable ', { noremap = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'H', '<cmd>VimwikiTableMoveColumnLeft<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'L', '<cmd>VimwikiTableMoveColumnRight<CR>', { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = { '*.md', '*.wiki' },
  callback = function()
    local title = (vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')):gsub('_', ' ')

    if title:match '%.md$' then
      title = title:sub(0, title:len() - 3)
    end

    local keysequence = 'i# ' .. title .. '<CR><CR><Esc>'
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keysequence, true, false, true), 'n', false)
  end,
})

-- xaml -> xml

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.xaml',
  callback = function()
    vim.bo.filetype = 'xml'
  end,
})

-- conf -> bash

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.conf',
  callback = function()
    vim.bo.filetype = 'bash'
  end,
})

-- NOTE: Fern

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fern',
  nested = true,
  callback = function(args)
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

    -- NOTE: Fern Preview Window

    vim.api.nvim_buf_set_keymap(0, 'n', 'p', '<Plug>(fern-action-preview:toggle)', { desc = 'Toggle preview window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-p>', '<Plug>(fern-action-preview:auto:toggle)', { desc = 'Toggle auto preview window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-d>', '<Plug>(fern-action-preview:down:half)', { desc = 'Scroll down in preview window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-u>', '<Plug>(fern-action-preview:up:half)', { desc = 'Scroll up in preview window' })
  end,
})

-- Highlight on yank

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
