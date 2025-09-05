return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'live_grep_args')

    -- TODO: Move to keymaps lua/keymaps.lua

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    -- vim.keymap.set('n', '<leader>sg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = '[S]earch by [G]rep (args)' })
    vim.keymap.set('n', '<leader>sD', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    -- Shortcut for searching inside your Neovim configuration files
    vim.keymap.set('n', '<leader>sN', function()
      builtin.live_grep { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch in [N]eovim files' })
    -- TODO: Change to live_grep_args if needed

    -- vim.keymap.set('n', '<leader>sN', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = '[S]earch in [N]eovim files' })

    -- Shortcut for searching inside your Neovim data files
    vim.keymap.set('n', '<leader>sd', function()
      builtin.find_files { cwd = vim.fn.stdpath 'data' }
    end, { desc = '[S]earch [D]otnet Projects' })

    vim.keymap.set('n', '<leader>sD', function()
      builtin.find_files { cwd = vim.fn.stdpath 'data' }
    end, { desc = '[S]earch Nvim-[D]ata files' })

    -- Shortcut for sarching files in Work directory

    vim.keymap.set('n', '<leader>sF', function()
      builtin.find_files { cwd = vim.g.global_workpath }
    end, { desc = '[S]earch Work Files' })

    vim.keymap.set('n', '<leader>sg', function()
      builtin.find_files { cwd = vim.g.global_workpath }
    end, { desc = '[S]earch Gods plan' })

    vim.keymap.set('n', '<leader>gs', function()
      builtin.find_files { cwd = vim.g.school }
    end, { desc = '[S]earch inside School Directory' })

    -- Shortcut for sarching inside files in Work directory

    vim.keymap.set('n', '<leader>sW', function()
      builtin.live_grep { cwd = vim.g.global_workpath }
    end, { desc = '[S]earch inside Work Files' })

    -- Shortcuts for Grepping

    vim.keymap.set('n', '<leader>gc', function()
      builtin.live_grep()
    end, { desc = '[G]rep CWD' })

    vim.keymap.set('n', '<leader>gw', function()
      builtin.live_grep { cwd = vim.g.workpath }
    end, { desc = '[G]rep inside Work' })

    vim.keymap.set('n', '<leader>gp', function()
      builtin.live_grep { cwd = vim.g.poshmodulepath }
    end, { desc = '[G]rep inside Posh Modules' })

    vim.keymap.set('n', '<leader>ga', function()
      builtin.live_grep { cwd = vim.g.ahkpath }
    end, { desc = '[G]rep inside AutoHotKey' })

    vim.keymap.set('n', '<leader>gg', function()
      builtin.live_grep { cwd = vim.g.ahkpath }
    end, { desc = '[G]rep inside Gods Plan' })

    vim.keymap.set('n', '<leader>gn', function()
      builtin.live_grep { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[G]rep inside Nvim Config' })

    vim.keymap.set('n', '<leader>gd', function()
      builtin.live_grep { cwd = vim.g.dotnetpath }
    end, { desc = '[G]rep inside Dotnet Projects' })

    vim.keymap.set('n', '<leader>gD', function()
      builtin.live_grep { cwd = vim.fn.stdpath 'data' }
    end, { desc = '[G]rep inside Nvim Data' })

    vim.keymap.set('n', '<leader>gs', function()
      builtin.live_grep { cwd = vim.g.school }
    end, { desc = '[G]rep inside School Directory' })
  end,
}
