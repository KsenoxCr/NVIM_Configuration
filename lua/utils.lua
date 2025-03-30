local M = {}

function M.is_dir(path)
  local status = vim.loop.fs_stat(path)
  return status and status.type == 'Directory'
end

function M.is_file(path)
  local status = vim.loop.fs_stat(path)
  return status and status.type == 'File'
end

return M
