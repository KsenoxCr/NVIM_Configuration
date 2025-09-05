M = {}

function M.GetSelectedNodePath(type)
  -- Acquiring fern node's path under caret

  if vim.bo.filetype ~= 'fern' then
    return false, 'Not in a Fern buffer.'
  end

  type = type or 'file'

  local status_ok, node = pcall(function()
    vim.fn['fern#internal#get_cursor_node']()
  end)

  if not status_ok then
    return false, 'Failed to retrieve Fern node: ' .. tostring(node)
  end

  if type ~= 'file' and type ~= 'directory' then
    return false, "'" .. type .. "' is not a valid node type"
  end

  if node == nil then
    return false, 'Caret is not on a node'
  end

  if (node.is_directory == 1 and type == 'directory') or (node.is_directory == 0 and type == 'file') then
    return true, node._path
  end

  return false, 'Node under caret is not a ' .. type
end

function M.ChangeTermDirectory()
  -- Changing underlying terminal sessions directory
  -- to one under caret on fern explorer

  local path_acquired, path = M.GetSelectedNodePath 'directory'

  if not path_acquired then
    print("Couldn't change directory: " .. path)
    return
  end

  vim.cmd('cd ' .. vim.fn.fnameescape(path))
  print('Changed directory successfully to: ' .. vim.fn.getcwd())
end

return M
