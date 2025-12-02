-- lua/plugins/copilot-lua.lua
return {
  'zbirenbaum/copilot.lua',
  dependencies = {
    'zbirenbaum/copilot-cmp',
  },
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<C-y>',
          accept_word = false,
          accept_line = false,
          dismiss = '<C-b]>',
          next = '<C-k>',
          prev = '<C-j>',
        },
      },
      panel = { enabled = true },
      filetypes = {
        markdown = false,
        vimwiki = false,
      },
    }
  end,
}
