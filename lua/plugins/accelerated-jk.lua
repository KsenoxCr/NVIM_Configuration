-- Plugin 1 fast.nvim: Fast cursor movement
return {
  'rhysd/accelerated-jk',
  -- event = 'VimEnter',
  config = function()
    -- Map `j` and `k` to the accelerated movement using <Plug>
    vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', { noremap = true, silent = true })
  end,
}
