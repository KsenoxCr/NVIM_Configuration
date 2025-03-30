-- NOTE: OS-Agnostic nvim-data to package.path for requiring modules

-- Detect OS

local os_name = jit.os

-- Append nvim-data to package.path with OS specific config path

if os_name == 'Windows' then
  package.path = package.path .. ';' .. os.getenv 'LOCALAPPDATA' .. '\\nvim-data\\?.lua'
elseif os_name == 'Linux' then
  package.path = package.path .. ';' .. os.getenv 'XDG_DATA_HOME' .. '/nvim/?.lua' or package.path .. ';' .. os.getenv 'HOME' .. '.local/share/nvim/?.lua'
end

vim.opt.encoding = 'utf-8' -- Sets the internal character encoding.
vim.opt.fileencoding = 'utf-8' -- Sets the encoding for files

require 'options'
require 'autocmds'
require 'usercmds'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update

require('lazy').setup {
  spec = {
    { import = 'plugins' },
    { import = 'plugins.lsp' },
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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
-- require 'custom.init'

-- Sets colors to comments, line numbers Above, Current and Below  in this order
vim.o.termguicolors = true
vim.api.nvim_set_hl(0, 'Comment', { fg = '#A0A0A0' })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#ca7872', bold = true })

-- vim.cmd.echo 'g:'
