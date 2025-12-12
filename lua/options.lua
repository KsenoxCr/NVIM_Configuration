vim.env.LANG = 'en_US.UTF-8'

-- VimWiki

local os_name = jit.os

-- Globals

vim.g.have_nerd_font = true

-- Paths

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Windows only

if os_name == 'Windows' then
  vim.g.wikidir = os.getenv 'USERPROFILE' .. '/OneDrive/Tiedostot/Gods_Plan/'
  vim.g.appdata = os.getenv 'LOCALAPPDATA'
  vim.g.fsroot = 'C:/'
  vim.g.weeks = 'C:/Users/aksum/OneDrive/Gods_Plan/weeks'
end

-- Linux only

if os_name == 'Linux' then
  vim.g.wikidir = os.getenv 'HOME' .. '/gods_plan'
  vim.g.appdata = os.getenv 'HOME' .. '/share/local'
  vim.g.fsroot = '/'
  vim.g.practice = '~/programming/practice'
  vim.g.tmuxconf = '~/.tmux.conf'
  vim.g.tmuxinator = '~/.config/tmuxinator'
  vim.g.programming = '~/programming'
  vim.g.templatepath = '~/templates'
  vim.g.aiprompts = '~/ai_prompt_library'
  vim.g.posh = '~/scripting/posh'
  vim.g.bash = '~/scripting/bash'
  vim.g.scripting = '~/scripting'
  vim.g.claudeconf = '~/.config/Claude/claude_desktop_config.json'
  vim.g.weeks = '~/gods_plan/weeks'
  vim.g.swap = vim.fn.stdpath 'data' .. '/swap'
  vim.g.bashrc = '~/.bashrc'
  vim.g.zshrc = '~/.zshrc'
  vim.g.weeks = '~/gods_plan/weeks'
  vim.g.hyprconf = '~/.config/hypr/hyprland.conf'
  vim.g.swayconf = '~/.config/sway/config'
  vim.g.kittyconf = '~/.config/kitty/kitty.conf'
  vim.g.waybarconf = '~/.config/waybar/config.jsonc'
  vim.g.waybarcss = '~/.config/waybar/style.css'
end

-- Filetype extensions

vim.filetype.add {
  extension = {
    psm1 = 'ps1',
    psd1 = 'ps1',
  },
}

-- OPTIONS

vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.o.conceallevel = 0
vim.opt.compatible = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- VimWiki

if require('utils').is_dir(vim.g.wikidir) then
  vim.g.vimwiki_list = {
    { path = vim.g.wikidir, syntax = 'markdown', ext = '.md', custom_wiki2html = 'pandoc', links_space_char = '_', list_type = 2 },
  }
end

vim.cmd 'filetype plugin on'

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
