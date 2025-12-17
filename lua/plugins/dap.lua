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
      '<leader>rb',
      function()
        require('dap').clear_breakpoints()
      end,
      desc = 'Debug: Clear Breakpoints',
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

    -- JS/TS via Mason's js-debug-adapter

    local js_debug_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter'

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = 8123,
      executable = {
        command = 'node',
        args = { js_debug_path .. '/js-debug/src/dapDebugServer.js', '8123' },
      },
    }

    dap.adapters['pwa-chrome'] = {
      type = 'server',
      host = 'localhost',
      port = 8124,
      executable = {
        command = 'node',
        args = { js_debug_path .. '/js-debug/src/dapDebugServer.js', '8124' },
      },
    }

    local function pick_file()
      return vim.fn.expand '%:p'
    end

    dap.configurations.typescript = {
      -- A) Run current TS file (no project)
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'TS: run current file (tsx)',
        cwd = vim.fn.getcwd(),
        runtimeExecutable = 'node',
        runtimeArgs = {
          '--inspect',
          -- use tsx to execute TS directly:
          vim.fn.exepath 'tsx',
        },
        args = { pick_file() },
        sourceMaps = true,
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
        skipFiles = { '<node_internals>/**', '**/node_modules/**' },
      },

      -- B) Attach to an already-running node --inspect process
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Node: attach (9229)',
        port = 9229,
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        skipFiles = { '<node_internals>/**', '**/node_modules/**' },
      },
    }

    dap.configurations.javascript = dap.configurations.typescript

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
