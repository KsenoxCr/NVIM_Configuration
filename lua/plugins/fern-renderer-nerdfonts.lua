return {
  'lambdalisue/vim-fern-renderer-nerdfont',
  dependencies = { 'lambdalisue/vim-nerdfont', 'lambdalisue/fern.vim' },
  init = function()
    vim.g['fern#renderer'] = 'nerdfont'
  end,
}
