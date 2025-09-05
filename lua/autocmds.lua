-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`

local map = vim.keymap.set

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'ps1', 'psm1', 'psd1' },
  callback = function()
    -- If treesitter doesn't auto highlight based on FileType

    -- vim.cmd 'TSEnable powershell'

    vim.keymap.set('n', '<leader>P', function()
      require('powershell').toggle_term()
    end, { buffer = 0, desc = 'Toggle Powershell terminal' })

    vim.keymap.set({ 'n', 'x' }, '<leader>R', function()
      require('powershell').eval()
    end, { buffer = 0, desc = 'Evaluate posh expression in terminal' })
  end,
})

-- NOTE: VimWiki

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'vimwiki',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-y>', '<cmd>VimwikiToggleListItem<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'T', ':VimwikiTable ', { noremap = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'H', '<cmd>VimwikiTableMoveColumnLeft<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'L', '<cmd>VimwikiTableMoveColumnRight<CR>', { noremap = true, silent = true })
    map('n', '<C-p>', require('custom.vimwiki-fn').AddTag, { buffer = 0, desc = 'Add priority tag' })
    map('n', '<C-c>', function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('i- [ ]<Esc>', true, false, true), 'n', false)
    end, { buffer = 0, desc = 'Insert checkbox' })
  end,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = { '*.md', '*.wiki' },
  callback = function()
    -- sculpting title from file name, replacing underscores with whitespaces

    local title = (vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')):gsub('_', ' ')

    -- Removing file extension from title

    if title:match '%.md$' then
      title = title:sub(0, title:len() - 3)
    end

    local keysequence = 'i# ' .. title .. '<CR><CR><Esc>'
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keysequence, true, false, true), 'n', false)
  end,
})

-- NOTE: Fern

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fern',
  nested = true,
  callback = function(args)
    -- Faster window navigation

    vim.api.nvim_buf_set_keymap(0, 'n', '<C-k>', '<C-w>k', { noremap = true, desc = 'Move focus to the top window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-j>', '<C-w>j', { noremap = true, desc = 'Move focus to the bottom window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-h>', '<C-w>h', { noremap = true, desc = 'Move focus to the left window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-l>', '<C-w>l', { noremap = true, desc = 'Move focus to the right window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<ESC>', '<cmd>close<CR>', { noremap = true, desc = 'Move focus to the right window' })

    -- Faster file navigation

    vim.api.nvim_buf_set_keymap(0, 'n', 's', '<Plug>(leap-forward-to)', { desc = 'Leap forward to' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'w', '<Plug>(fern-action-open-or-expand)', { desc = 'open or expand' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'e', '<Plug>(fern-action-collapse)', { desc = 'collapse' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'h', '<Plug>(fern-action-open-or-enter)', { desc = 'open or enter' })
    vim.api.nvim_buf_set_keymap(0, 'n', 'f', '<Plug>(fern-action-leave)', { desc = 'leave' })

    -- FIX: Ghetto version of opening file outside of popup
    -- TODO: reform this so that it works with
    -- fern-action-open-or-enter && fern-action-open-or-enter

    -- vim.api.nvim_buf_set_keymap(0, 'n', 'g', require('custom.fern-popup').open, { desc = 'open file outside of fern popup' }) -- Doesn't cause delay due to require adding fern-popup into package.loaded

    -- NOTE: Fern Preview Window

    vim.api.nvim_buf_set_keymap(0, 'n', 'p', '<Plug>(fern-action-preview:toggle)', { desc = 'Toggle preview window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-p>', '<Plug>(fern-action-preview:auto:toggle)', { desc = 'Toggle auto preview window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-d>', '<Plug>(fern-action-preview:down:half)', { desc = 'Scroll down in preview window' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-u>', '<Plug>(fern-action-preview:up:half)', { desc = 'Scroll up in preview window' })

    vim.keymap.set('n', '<leader>cd', function()
      print 'C-CR Works'
      require('custom.fern-fn').ChangeTermDirectory()
    end, { buffer = 0, desc = 'Change to directory under caret' })

    -- if vim.fn.exists '*fern-develop-helper' then
    --   print 'develop exists'
    -- else
    --   print 'develop doesnt exist'
    -- end

    -- vim.fn['fern-develop-helper.sync.get_root_node']()

    -- local ok, root = pcall(function()
    --   return vim.fn['fern-develop-helper.sync.get_root_node']()
    -- end)
    --
    -- if not ok then
    --   print 'not ok'
    -- end

    -- NOTE: Fern Visual Mode Deletion

    -- DEBUG

    -- autocmd = Mode changed
    -- if mode visual then
    --    selectedLines[1] = cursor position
    --    selectedLines[2] = selectedLines[1]
    --    autocmd: CursorMoved
    --      selectedLines[2] = cursor position
    -- else
    --   selectedLines = { 0, 0 }

    -- Keymap visual mode D
    --    if selectedLines[1] not equal 0
    --      if selectedLines[1] <= selectedLines[2] then
    --        for i = selectedLines[1] to selectedLines[2]
    --          set cursor to 0, {i, 0}
    --          call fern-action-remove with
    --      else
    --        for i = selectedLines[2], selectedLines[1], -1 do
    --          set cursor to 0, {i, 0}
    --          call fern-action-remove with
    --

    local selectedLines = { 0, 0 } -- start_pos, end_pos

    local grp = vim.api.nvim_create_augroup('Ephemeral', { clear = true })

    vim.api.nvim_create_autocmd('ModeChanged', {
      pattern = '*',
      callback = function()
        local mode = vim.fn.mode()

        if mode == 'v' or mode == 'V' then
          selectedLines[1] = vim.fn.getpos('.')[2]
          selectedLines[2] = selectedLines[1]
          -- print(vim.inspect(selectedLines))

          vim.api.nvim_create_autocmd('CursorMoved', {
            group = grp,
            buffer = args.buf,
            callback = function()
              selectedLines[2] = vim.fn.getpos('.')[2]
              -- print(vim.inspect(selectedLines))
            end,
          })
        else
          vim.api.nvim_clear_autocmds { group = 'Ephemeral' }
          selectedLines[1] = 0
          selectedLines[2] = 0
          -- print(vim.inspect(selectedLines))
        end
      end,
    })

    vim.keymap.set('v', 'D', function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)

      if selectedLines[1] ~= 0 then
        -- local og_confirm = vim.fn.confirm
        --
        -- ---@diagnostic disable-next-line:duplicate-set-field
        -- vim.fn.confirm = function(...)
        --   return 1
        -- end

        local start_line = math.min(selectedLines[1], selectedLines[2])
        local end_line = math.max(selectedLines[1], selectedLines[2])

        for i = start_line, end_line do
          vim.api.nvim_win_set_cursor(0, { i, 0 })
          print('line: ' .. i)
          -- TODO: Find a way to sleep inside loop asynchronously

          -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(fern-action-trash)', true, false, true), 'n', false)
          -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('y<CR>', true, false, true), 'n', false)
        end

        -- vim.fn.confirm = og_confirm
      end
    end, { buffer = 0, desc = 'Delete selected items' })
    --   -- Save selected lines
    --
    --   local start_pos = vim.fn.getpos "'<"
    --   local end_pos = vim.fn.getpos "'>"
    --
    --   if start_pos[2] == 0 then
    --     vim.notify('start_pos not set!', vim.log.levels.ERROR)
    --     return
    --   end
    --
    --   -- Prompt for assurance
    --
    --   local choice = vim.fn.confirm('Delete these files?', '&Yes\n&No', 2, 'Question')
    --
    --   if choice ~= 1 then
    --     return
    --   end
    --
    --   -- Ephemeral Autocommands for inhibiting interfering operations during line iteration and item deletion
    --
    --   local grp = vim.api.nvim_create_augroup('EphemeralAutocmds', { clear = true })
    --
    --   vim.api.nvim_create_autocmd({ 'BufLeave', 'WinLeave', 'InsertEnter' }, {
    --     group = grp,
    --     buffer = args.buf,
    --     callback = function()
    --       vim.schedule(function()
    --         vim.notify('Action stopped while deletion ongoing', vim.log.levels.WARN)
    --         vim.api.nvim_set_current_buf(args.buf)
    --         vim.cmd 'stopinsert'
    --       end)
    --     end,
    --   })
    --
    --   -- Overriding vim.fn.confirm for disabling confirmation prompts while deleting files
    --
    --   local og_confirm = vim.fn.confirm
    --
    --   ---@diagnostic disable-next-line:duplicate-set-field
    --   vim.fn.confirm = function(...)
    --     return 1
    --   end
    --
    --   -- Exit visual mode for fern-action-trash to work
    --
    --   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
    --
    --   -- Delete file under each line
    --
    --   for i = start_pos[2], end_pos[2] do
    --     vim.defer_fn(function()
    --       vim.api.nvim_win_set_cursor(0, { i, 0 })
    --     end, 500)
    --     -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(fern-action-trash)', true, false, true), 'n', false)
    --   end
    --
    --   -- Removing ephemeral autocommands after deletion completed
    --
    --   vim.api.nvim_clear_autocmds { group = 'EphemeralAutocmds' }
    --
    --   -- Reactivating vim.fn.confirm
    --
    --   vim.fn.confirm = og_confirm
    -- end, { buffer = 0, desc = 'Delete selected items' })
  end,
})

vim.api.nvim_create_autocmd('BufNewfile', {
  pattern = '*.cs',
  callback = function()
    print ''
    vim.cmd 'Template default.cs'
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
