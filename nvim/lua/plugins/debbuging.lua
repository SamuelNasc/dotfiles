return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require('dapui').setup()
      local dap, dapui = require('dap'), require('dapui')

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {})
      vim.keymap.set('n', '<F5>', dap.continue, {})
      vim.keymap.set('n', '<F10>', dap.step_over, {})
      vim.keymap.set('n', '<F11>', dap.step_into, {})
      vim.keymap.set('n', '<F12>', dap.step_out, {})
      vim.keymap.set('n', '<leader>dt', dap.terminate, {})
      vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, {})

      local mason_path = vim.fn.stdpath('data') .. '/mason/packages/netcoredbg/netcoredbg'
      local netcoredbg_adapter = {
        type = 'executable',
        command = mason_path,
        args = { '--interpreter=vscode' },
      }
      dap.adapters.netcoredbg = netcoredbg_adapter --needed for normal debugging
      dap.adapters.coreclr = netcoredbg_adapter --needed for unit test debugging

      local dotnet = require('configs.auto-detect-csproj')

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'launch - netcoredbg',
          request = 'launch',
          program = function()
            return dotnet.build_dll_path()
          end,
          justMyCode = false,
        }
      }
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      -- debugpy runs from mason's venv; your code still runs with the project's
      -- interpreter ($VIRTUAL_ENV, ./venv or ./.venv), picked by dap-python
      require('dap-python').setup(vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python')
      local dap = require('dap')
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Launch current file',
        program = '${file}',
        justMyCode = false
      })
    end
  }
}

