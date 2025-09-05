return {
  'hlissner/vim-multiedit',
  config = function()
    vim.keymap.set('n', '<leader>mn', ':MultieditHop 1<CR>')
    vim.keymap.set('n', '<leader>mp', ':MultieditHop -1<CR>')

    -- Disable buggy non existent keymap
    vim.keymap.set('n', '<leader>må', '<NOP>')
  end,
}
