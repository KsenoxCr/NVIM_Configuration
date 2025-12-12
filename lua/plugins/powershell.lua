-- local powershell = require 'mason-core.managers.powershell'

if jit.os == 'Windows' then
  return {
    'TheLeoP/powershell.nvim',
    config = function()
      local editorservices_path

      if jit.os == 'Windows' then
        editorservices_path =
        'C:/Tools/PowerShellEditorServices/module' -- Might need to be just "C:/Tools/PowerShellEditorServices"
      elseif jit.os == 'Linux' then
        -- TODO: Add linux path to PowershellEditorServices
      end

      require('powershell').setup {
        bundle_path = editorservices_path,
      }

      -- vim.schedule(function()
      --   local configs = require('dap').configurations
      --
      --   if configs['ps1'] and not configs['powershell'] then
      --     configs['powershell'] = configs['ps1']
      --     configs['ps1'] = nil
      --   end
      -- end)
    end,
  }
else
  return {}
end
