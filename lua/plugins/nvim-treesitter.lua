package.path = package.path .. ';' .. os.getenv 'LOCALAPPDATA' .. '\\nvim-data\\lazy\\nvim-treesitter\\lua\\?.lua'
local status_ok, treesitter_install = pcall(require, 'nvim-treesitter.install')
if not status_ok then
  print 'Treesitter status: not ok'
  print('Error:', treesitter_install)
  return {}
end

treesitter_install.compilers = { 'clang' }

return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = {
      'bash',
      'cpp',
      'c_sharp',
      'c',
      'diff',
      'html',
      'css',
      'javascript',
      'php',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'powershell',
      'vim',
      'vimdoc',
    },

    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby', 'markdown' },

      indent = { enable = true, disable = { 'ruby' } },
    },
    -- matchup = {
    --   enable = true,
    -- }
    -- playground = {
    --   enable = true,
    --   updatetime = 25, -- Debounce time for updates (ms)
    --   persist_queries = false, -- Don’t save queries across sessions
    -- },
    -- config = function()
    --   -- NOTE: Ghetto fix for having to reinstall parsers
    --   local parsers = 'lua markdown c_sharp cpp'
    --   local ts_update = string.format('TSUpdate %s', parsers)
    --   vim.cmd 'TSUpdate '
    -- end,
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    local parsers = require 'nvim-treesitter.parsers'

    local posh_fts = { 'ps1', 'psm1', 'psd1' }

    posh_fts.contains = require('utils').contains

    local og_ft_to_lang = parsers.ft_to_lang

    parsers.ft_to_lang = function(ft)
      if posh_fts:contains(ft) then
        return 'powershell'
      end
      return og_ft_to_lang(ft)
    end
  end,
}
-- There are additional nvim-treesitter modules that you can use to interact
-- with nvim-treesitter. You should go explore a few and see what interests you:
--
--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
