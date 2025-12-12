return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    -- Telescope integration

    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    -- Keymaps

    local map = vim.keymap.set

    map('n', '<leader>h', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window' })

    map('n', '<leader>a', function()
      harpoon:list():add()
    end)

    map('n', '<leader>R', function()
      harpoon:list():remove()
    end)

    map('n', '<leader>X', function()
      harpoon:list():clear()
    end)

    map('n', '<leader>1', function()
      harpoon:list():select(1)
    end)

    map('n', '<leader>2', function()
      harpoon:list():select(2)
    end)
    map('n', '<leader>3', function()
      harpoon:list():select(3)
    end)
    map('n', '<leader>4', function()
      harpoon:list():select(4)
    end)
    map('n', '<leader>5', function()
      harpoon:list():select(5)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    map('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)
    map('n', '<C-S-N>', function()
      harpoon:list():next()
    end)
  end,
}
