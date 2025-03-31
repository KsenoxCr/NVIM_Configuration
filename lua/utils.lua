local M = {}

function M.exists(path)
  local ok, err, err_code = os.rename(path, path)
  if not ok then
    if err_code == 13 then
      -- Permission denied but it exists
      return true
    end
  end
  return ok, err
end

function M.is_dir(path)
  return M.exists(path .. '/')
end

return M
