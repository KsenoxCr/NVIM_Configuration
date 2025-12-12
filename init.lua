local os_name = jit.os

if os_name == 'Windows' then
  package.path = package.path .. ';' .. os.getenv 'LOCALAPPDATA' .. '\\nvim-data\\?.lua'
elseif os_name == 'Linux' then
  package.path = package.path .. ';' .. os.getenv 'HOME' .. '/.config/nvim/?.lua'
end

require 'options'
require 'autocmds'
require 'usercmds'

-- Lazy Plugin Manager

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Configure & install plugins

require('lazy').setup {
  spec = {
    { import = 'plugins' },
    { import = 'plugins.lsp' },
  },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}

require('telescope').load_extension 'find_template'

require 'keymaps'
require 'configs.init'

-- Sets colors to comments, line numbers Above, Current and Below  in this order
vim.o.termguicolors = true
vim.api.nvim_set_hl(0, 'Comment', { fg = '#A0A0A0' })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#ca7872', bold = true })
