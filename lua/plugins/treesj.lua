return {
  'Wansmer/treesj', -- Split/join TS imports
  dependencies = 'nvim-treesitter/nvim-treesitter',
  opts = { use_default_keymaps = false },
  keys = {
    { 'gS', '<cmd>TSJSplit<cr>' },
    { 'gJ', '<cmd>TSJJoin<cr>' },
  },
}
