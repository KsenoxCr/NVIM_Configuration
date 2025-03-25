local M = {}

M.popup = function()
  -- Initializing new buffer as a scaffold for Fern to latch on to

  local fern_buf = vim.api.nvim_create_buf(false, true)

  -- Window size and position
  local width = math.floor(vim.o.columns * 0.25)
  local height = math.floor(vim.o.lines * 0.9)
  local row = math.floor(1)
  local col = math.floor(1)

  -- Floating window config
  local win_opts = {
    style = 'minimal',
    relative = 'editor',
    anchor = 'NW',
    row = row,
    col = col,
    width = width,
    height = height,
    border = 'none',
  }

  -- New Window with the new buffer attached

  vim.api.nvim_open_win(fern_buf, true, win_opts)

  -- Invoke Fern inside the new window and let it integrate itself

  vim.schedule(function()
    vim.cmd 'Fern . -stay'
  end)
end

M.open = function()
  -- #opens file in the previous or a new buffer (nvim decides)

  -- WARN: Already checked by autocommand (fileType = "fern")

  -- -- Making sure function is only used within fern
  --
  -- if vim.bo.filetype ~= 'fern' and vim.fn.exists 'b:fern' then
  --   return
  -- end

  -- Opening a file or expanding a directory

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(fern-action-open-or-expand)', true, false, true), 'n', false)
  -- vim.api.nvim_feedkeys('w', 'n', true)

  -- Save reference to current buffer (opened file)
  -- Save reference to popup window

  local opened_file_buf = vim.api.nvim_get_current_buf()
  local current_win = vim.api.nvim_get_current_win()

  -- Closing the popup if file was opened and loading the file buffer into new window

  -- TODO: Check whether scheduling is just slowing the process don't redundantly

  vim.schedule(function()
    if vim.bo.filetype ~= 'fern' then
      -- Close popup window

      vim.api.nvim_win_close(current_win, true)

      -- Open the buffer in the new window if it's still valid

      if vim.api.nvim_buf_is_loaded(opened_file_buf) then
        vim.api.nvim_set_current_buf(opened_file_buf)
      end
    end
  end)
end

return M
