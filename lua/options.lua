vim.env.LANG = 'en_US.UTF-8'

local os_name = jit.os

-- NOTE: VimWiki

local wikiDir

if os_name == 'Windows' then
  wikiDir = os.getenv 'USERPROFILE' .. '/OneDrive/Tiedostot/Gods_Plan/'
elseif os_name == 'Linux' then
  wikiDir = os.getenv 'HOME' .. '/gods_plan'
end

if require('utils').is_dir(wikiDir) then
  vim.g.vimwiki_list = {
    { path = wikiDir, syntax = 'markdown', ext = '.md', custom_wiki2html = 'pandoc', links_space_char = '_', list_type = 2 },
  }
end

-- NOTE: Globals

if os_name == 'Windows' then
  vim.g.appdata = os.getenv 'LOCALAPPDATA'
  vim.g.root = 'C:/'
  vim.g.tech_problems = 'C:/Users/aksum/OneDrive/Gods_Plan/Tech_Problems.md'
  vim.g.brain_ram = 'C:/Users/aksum/OneDrive/Gods_Plan/Brain_Ram.md'
  vim.g.paths = 'C:/Users/aksum/OneDrive/Gods_Plan/Paths.md'
  vim.g.documents = 'C:/Users/aksum/OneDrive/Gods_Plan/Documentations.md'
  vim.g.weeks = 'C:/Users/aksum/OneDrive/Gods_Plan/weeks'
  vim.g.toolspath = 'C:/Tools'
elseif os_name == 'Linux' then
  vim.g.practice = '~/programming/practice'
  vim.g.tmuxconf = '~/.tmux.conf'
  vim.g.tmuxinator = '~/.config/tmuxinator'
  vim.g.appdata = os.getenv 'HOME' .. '/share/local'
  vim.g.root = '/'
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  vim.g.programming = '~/programming'
  vim.g.templatepath = '~/templates'
  vim.g.aiprompts = '~/ai_prompt_library'
  vim.g.posh = '~/scripting/posh'
  vim.g.bash = '~/scripting/bash'
  vim.g.n8n = '~/scripting/n8n'
  vim.g.profilepath = '~/scripting/shell_profiles'
  vim.g.ahkpath = '~/scripting/ahk'
  vim.g.godsplan = wikiDir
  vim.g.dotnetpath = '~/programming/dotnet'
  vim.g.school = '~/school'
  vim.g.scripting = '~/scripting'
  vim.g.claudeconf = '~/.config/Claude/claude_desktop_config.json'
  vim.g.bash = '~/scripting/bash'
  vim.g.weeks = '~/gods_plan/weeks'
  vim.g.swap = vim.fn.stdpath 'data' .. '/swap'
  vim.g.bashrc = '~/.bashrc'
  vim.g.toolspath = '/usr/share'
  vim.g.tech_problems = '~/gods_plan/Tech_Problems.md'
  vim.g.brain_ram = '~/gods_plan/Brain_Ram.md'
  vim.g.paths = '~/gods_plan/Paths.md'
  vim.g.documents = '~/gods_plan/Documentations.md'
  vim.g.weeks = '~/gods_plan/weeks'
  vim.g.hyprconf = '~/.config/hypr/hyprland.conf'
  vim.g.swayconf = '~/.config/sway/config'
  vim.g.kittyconf = '~/.config/kitty/kitty.conf'
  vim.g.waybarconf = '~/.config/waybar/config.jsonc'
  vim.g.waybarcss = '~/.config/waybar/style.css'
end

vim.g.have_nerd_font = true

-- NOTE: Filetype extensions

vim.filetype.add {
  extension = {
    psm1 = 'ps1',
    psd1 = 'ps1',
  },
}

-- NOTE: OPTIONS

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

vim.cmd 'filetype plugin on'

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
