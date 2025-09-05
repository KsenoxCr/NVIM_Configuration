return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    window = {
      border = 'rounded', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
    delay = 0,
    keys = {
      scroll_down = '<C-d>', -- binding to scroll down inside the popup
      scroll_up = '<C-u>', -- binding to scroll up inside the popup
    },
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },
    -- Document existing key chains
    spec = {
      { '<leader>a', '<cmd>Alpha<CR>', desc = 'Alpha' },
      -- { '<leader>e1', '<cmd>Fern %:h<CR>', desc = 'Explorer (Current Buf)' },
      -- { '<leader>e2', '<cmd>Fern ' .. vim.g.poshmodulepath .. '<CR>', desc = 'Explorer (Posh Modules)' },
      -- { '<leader>e3', '<cmd>Fern ' .. vim.g.ahkpath .. '<CR>', desc = 'Explorer (AutoHotKey)' },
      -- { '<leader>e4', '<cmd>Fern ' .. vim.fn.stdpath 'config' .. '<CR>', desc = 'Explorer (Neovim config files)' },
      -- { '<leader>e5', '<cmd>Fern ' .. vim.fn.stdpath 'data' .. '<CR>', desc = 'Explorer (Neovim data files)' },
      -- { '<leader>E', '<cmd>Fern ' .. vim.g.workpath .. ' -reveal=%<CR>', desc = 'Explorer (CWD)' },
      { '<leader>p', '<cmd>Lazy<CR>', desc = 'Plugin Manager' },
      -- { '<leader>q', '<cmd>wqall!<CR>', desc = 'Quit' },
      { '<leader>e', group = '[E]xplorer' },
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>g', group = '[G]rep' },
      { '<leader>w', group = '[W]iki' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>l', group = 'VimTex', mode = { 'n', 'v' } },
      -- Surrond
      { 'cs', '<Plug>Csurround', desc = 'Change Surrounding' },
      { 'ds', '<Plug>Dsurround', desc = 'Delete Surrounding' },
    },
  },
  -- config = function()
  --   pcall(vim.keymap.del, 'n', '<Space>w') -- Deleting write mapping
  -- end,
  config = function(_, opts)
    local which_key = require 'which-key'
    which_key.setup(opts)
    pcall(vim.keymap.del, 'n', '<Space>w') -- Deleting write mapping
  end,
}
