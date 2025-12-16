-- debugger.lua
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'nvim-neotest/nvim-nio' },
    },

    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    'mxsdev/nvim-dap-vscode-js',
  },
  keys = {
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
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
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

    dap.configurations.cs = {
      {
        name = 'Launch .NET Core',
        type = 'coreclr',
        request = 'launch',
        preLaunchTask = function()
          local build_output = vim.fn.system 'dotnet build -c Debug 2>&1'
          if vim.v.shell_error ~= 0 then
            print('❌ Build failed:\n' .. build_output)
            return false
          end
          print '✅ Build succeeded!'
        end,
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
        console = 'integratedTerminal',
        internalConsoleOptions = 'openOnFirstSessionStart',
        terminal = 'integrated',
        stopAtEntry = false,
      },
    }

    -- Python (unchanged)
    dap.adapters.python = {
      type = 'executable',
      command = vim.fn.exepath 'python3',
      args = { '-m', 'debugpy.adapter' },
    }
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
          return vim.fn.exepath 'python3'
        end,
      },
    }

    -- Powershell (your original has a bug; leave behavior minimal + correct)
    -- If you actually want ps1/psm1, uncomment your adapter + configurations.
    -- dap.configurations.ps1 = { ... }
    -- dap.configurations.powershell = dap.configurations.ps1
    -- dap.configurations.psm1 = dap.configurations.ps1

    -- DAP UI
    dapui.setup {
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

    -- JS/TS via Mason's js-debug-adapter

    local mason_bin = vim.fn.stdpath 'data' .. '/mason/bin/js-debug-adapter'
    -- if vim.fn.has 'win32' == 1 then
    --   js_debug_cmd = mason_bin .. '.cmd'
    -- end

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = '127.0.0.1',
      port = '${port}',
      executable = {
        command = mason_bin,
        args = { '${port}' },
      },
    }

    for _, ft in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' } do
      dap.configurations[ft] = dap.configurations[ft] or {}
      vim.list_extend(dap.configurations[ft], {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch TS (ts-node/register)',
          cwd = '${workspaceFolder}',
          program = '${file}',
          runtimeExecutable = 'node',
          runtimeArgs = { '--enable-source-maps', '-r', 'ts-node/register' },
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
          skipFiles = { '<node_internals>/**', '${workspaceFolder}/node_modules/**' },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch TS (ts-node/esm)',
          cwd = '${workspaceFolder}',
          program = '${file}',
          runtimeExecutable = 'node',
          runtimeArgs = { '--enable-source-maps', '--loader', 'ts-node/esm' },
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
          skipFiles = { '<node_internals>/**', '${workspaceFolder}/node_modules/**' },
        },
      })
    end

    -- Breakpoint icons

    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for typ, icon in pairs(breakpoint_icons) do
      local name = 'Dap' .. typ
      local hl = (typ == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(name, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
