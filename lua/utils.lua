local M = {}

function M.exists(path)
  local ok, err, err_code = os.rename(path, path)
  if not ok then
    if err_code == 13 then
      -- FIX: Permission denied but it exists
      return true
    end
  end
  return ok, err
end

function M.is_dir(path)
  return M.exists(path .. '/')
end

function M:contains(value)
  for _, e in ipairs(self) do
    if e == value then
      return true
    end
  end

  return false
end

return M
