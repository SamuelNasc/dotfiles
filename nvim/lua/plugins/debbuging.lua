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
}

