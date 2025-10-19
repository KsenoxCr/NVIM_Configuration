-- debugger.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<S-F5>',
      function()
        require('dap').terminate()
        require('dapui').close()
      end,
      desc = 'Debug: Stop',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dap.defaults.fallback.terminal_win_cmd = 'belowright split new'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        --'delve',
        'codelldb',
        'netcoredbg',
        'PowerShellEditorServices',
        'bashdb',
      },
    }

    -- netcoredbg adapter for .NET
    dap.adapters.coreclr = {
      type = 'executable',
      command = 'netcoredbg',
      args = { '--interpreter=vscode' },
    }

    -- .NET configuration
    dap.configurations.cs = {
      {
        name = 'Launch .NET Core',
        type = 'coreclr',
        request = 'launch',
        preLaunchTask = function()
          local build_output = vim.fn.system 'dotnet build -c Debug 2>&1'

          if vim.v.shell_error ~= 0 then
            print('❌ Build failed:\n' .. build_output)
            return false -- Prevents launching the debugger
          end

          print '✅ Build succeeded!'
        end,
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
        console = 'integratedTerminal', -- This tells netcoredbg to use the integrated terminal.
        internalConsoleOptions = 'openOnFirstSessionStart', -- Opens the DAP UI console automatically
        terminal = 'integrated', -- Force integrated terminal
        stopAtEntry = false,
      },
    }

    -- EditorServices for Powershell

    -- dap.adapters.powershell = {
    --   type = 'executable',
    --   command = 'pwsh',
    --   args = {
    --     '-File',
    --     'C:/Tools/PowerShellEditorServices/module/PowerShellEditorServices/Start-EditorServices.ps1',
    --     '-HostName',
    --     'nvim',
    --     '-HostProfileId',
    --     'neovim',
    --     '-HostVersion',
    --     '1.0.0',
    --     '-BundledModulesPath',
    --     'C:/Tools/PowerShellEditorServices/module',
    --     '-LogPath',
    --     'C:/Temp/pses_log',
    --     '-SessionDetailsPath',
    --     'C:/Temp/Session.json',
    --     '-LogLevel',
    --     'Diagnostic',
    --     '-Stdio',
    --   },
    -- }

    -- Configuration for Powershell
    -- dap.configurations.ps1 = {
    --   {
    --     type = 'powershell',
    --     request = 'launch',
    --     name = 'Launch Powershell Script',
    --     script = '${file}',
    --     cwd = '${workspaceFolder}',
    --     stopOnEntry = true,
    --   },
    --   -- TODO: Config for launching function under caret
    -- }

    -- dap.configurations.powershell = dap.configurations.ps1
    dap.adapters.psm1 = dap.configurations.ps1
    dap.configurations.psm1 = dap.configurations.ps1

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- NOTE: Change breakpoint icons

    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
  end,
}
