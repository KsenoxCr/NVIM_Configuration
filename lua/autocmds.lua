-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fern',
  callback = function()
    -- Add faster window navigation

    vim.api.nvim_buf_set_keymap(0, 'n', '<C-k>', '<C-w>k', { noremap = true, desc = 'Move focus to the top window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-j>', '<C-w>j', { noremap = true, noremap = true, desc = 'Move focus to the bottom window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-h>', '<C-w>h', { noremap = true, desc = 'Move focus to the left window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-l>', '<C-w>l', { noremap = true, desc = 'Move focus to the right window' })

    -- Add faster file navigation

    vim.api.nvim_buf_set_keymap(0, 'n', 's', '<Plug>(leap-forward-to)', { noremap = true, desc = 'Leap forward to' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'w', '<Plug>(fern-action-open-or-expand)', { noremap = true, desc = 'Leap forward to' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'e', '<Plug>(fern-action-collapse)', { noremap = true, desc = 'Leap forward to' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'f', '<Plug>(fern-action-open-or-enter)', { noremap = true, desc = 'Leap forward to' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'h', '<Plug>(fern-action-leave)', { noremap = true, desc = 'Leap forward to' })
  end,
})

-- TODO: Move autocommands to own dir and add autocommand for removing c-h on fern files and add it to changing windoiws

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
