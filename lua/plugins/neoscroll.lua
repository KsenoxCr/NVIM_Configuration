return {
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup {
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>' },
    }

    vim.keymap.set('n', '<A-u>', '<C-b>', { desc = 'Scroll up fast' })
    vim.keymap.set('n', '<A-d>', '<C-f>', { desc = 'Scroll down fast' })
  end,
}
