-- NOTE: Environment

vim.env.LANG = 'en_US.UTF-8'

-- NOTE: GLOBALS
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.global_workpath = '~/Work'
vim.g.global_templatepath = vim.g.global_workpath .. '/templates'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

local wikiDir = os.getenv 'USERPROFILE' .. '\\work\\Gods_Plan\\'

vim.g.vimwiki_list = {
  { path = wikiDir, syntax = 'markdown', ext = '.md', custom_wiki2html = 'pandoc', links_space_char = '_', list_type = 2 },
}

-- NOTE: OPTIONS

vim.o.conceallevel = 0

vim.opt.compatible = false
vim.cmd 'filetype plugin on'

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Set tabs to use 4 spaces instead of 8
vim.o.tabstop = 4 -- Number of spaces a tab counts for
vim.o.softtabstop = 4 -- How many spaces Neovim uses for soft tabs
vim.o.shiftwidth = 4 -- Number of spaces to use for auto-indentation
vim.o.expandtab = true -- Convert tabs to spaces

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- NOTE: VimTex

vim.g.vimtex_view_method = 'general' --redundant because general is default value
vim.g.vimtex_view_general_viewer = 'C:\\Users\\kseno\\AppData\\Local\\SumatraPDF\\SumatraPDF.exe'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_quickfix_mode = 0 -- 0: disabled, 1: errors, 2: errors and warnings
vim.g.vimtex_mappings_enabled = 1 -- Uses default keymaps (<leader>l...)
