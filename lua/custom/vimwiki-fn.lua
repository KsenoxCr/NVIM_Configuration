-- NOTE: Ghetto solution for require
package.cpath = package.cpath .. ';C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree\\lib\\lua\\5.1\\?.dll'
package.cpath = package.cpath .. ';C:\\Program Files\\Neovim\\bin\\?.dll'

-- print(package.cpath)
-- local status_ok, lfs = pcall(require, 'lfs')
-- local status_ok, lfs = pcall(package.loadlib, 'C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree\\lib\\lua\5.1\\lfs.dll', 'luaopen_lfs')
local status_ok, lfs = pcall(package.loadlib, 'C:\\Program Files (x86)\\Lua\\5.1\\clibs\\luafilesystem_1_5_0_1-lfs.dll', '*')
if not status_ok then
  print 'lfs status not ok'
  return
end

function dirExists(dir)
  local attr = lfs.attributes(dir)
  return attr and attr.mode == 'directory'
end

function FindTemplates()
  local dir = os.getenv 'USERPROFILE' .. '//vimwiki//templates'

  local templates = {}

  if dirExists(dir) then
    for entry in lfs.dir(dir) do
      if entry ~= '.' and entry ~= '..' and (string.sub(entry, -3) == '.md' or string.sub(entry, -5) == '.wiki') then
        table.insert(templates, entry)
      end
    end
  end

  return templates
end

local M = {}

function M.ChooseTemplate()
  -- Finding all templates from templates directory
  -- If templates found then display menu to choose from

  -- foreach file in Userprofile/vimwiki/templates
  -- if filetype is vimwiki then add filename to templates array

  local templates = FindTemplates()

  for _, template in ipairs(templates) do
    print(template .. '\n')
  end

  -- New Buffer

  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, templates)

  -- Pop up window for menu
end

function M.CreateTemplate() end

-- M.ChooseTemplate()
-- print 'test'

-- vim.api.nvim_create_user_command('ChooseTemplate', M.ChooseTemplate(), {})
--
function M.AddPriorityTag()
  local input = vim.fn.nr2char(vim.fn.getchar())
  if vim.bo.filetype == 'vimwiki' then
    if input == '1' then
      vim.api.nvim_put({ '🔥 ' }, 'c', true, true)
    elseif input == '2' then
      vim.api.nvim_put({ '🔆 ' }, 'c', true, true)
    elseif input == '3' then
      vim.api.nvim_put({ '💤 ' }, 'c', true, true)
    end
  end
end

return M
