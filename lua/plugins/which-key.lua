return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function()
    local wk = require 'which-key'
    wk.setup {
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
    }
    wk.register {
      -- Added Alpha Keybinding
      ['<leader>a'] = { '<cmd>Alpha<cr>', 'Alpha' },
      ['<leader>e'] = { '<cmd>NvimTreeToggle<cr>', 'Explorer' }, -- File Explorer
      ['<leader>p'] = { '<cmd>Lazy<CR>', 'Plugin Manager' }, -- Invoking plugin manager
      ['<leader>q'] = { '<cmd>wqall!<CR>', 'Quit' }, -- Quit Neovim after saving the file
      ['<leader>w'] = { '<cmd>w!<CR>', 'Save' }, -- Save current file

      -- Telescope
      f = {
        name = 'File Search',
        c = { '<cmd>Telescope colorscheme<cr>', 'Colorscheme' },
        f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", 'Find files' },
        t = { '<cmd>Telescope live_grep <cr>', 'Find Text Pattern' },
        r = { '<cmd>Telescope oldfiles<cr>', 'Recent Files' },
      },

      s = {
        name = 'Search',
        h = { '<cmd>Telescope help_tags<cr>', 'Find Help' },
        m = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
        r = { '<cmd>Telescope registers<cr>', 'Registers' },
        k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
        c = { '<cmd>Telescope commands<cr>', 'Commands' },
      },
    }
  end,
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.opt.timeoutlen
    delay = 0,
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
      { '<leader>a', '<cmd>Alpha<cr>', desc = 'Alpha' },
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Explorer' },
      { '<leader>p', '<cmd>Lazy<CR>', desc = 'Plugin Manager' },
      { '<leader>q', '<cmd>wqall!<CR>', desc = 'Quit' },
      { '<leader>w', '<cmd>w!<CR>', desc = 'Save' },
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}
