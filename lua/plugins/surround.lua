return {
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup()

    vim.keymap.set('n', 'yq', '<Plug>(nvim-surround-normal)', { noremap = false, desc = 'You surround' })
    vim.keymap.set('n', 'yqq', '<Plug>(nvim-surround-normal-cur)', { noremap = false, desc = 'You surround' })
    vim.keymap.set('n', 'cq', '<Plug>(nvim-surround-change)', { noremap = false, desc = 'You surround' })
    vim.keymap.set('n', 'dq', '<Plug>(nvim-surround-delete)', { noremap = false, desc = 'You surround' })
  end,
}
