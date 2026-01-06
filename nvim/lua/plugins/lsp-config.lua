return {
  {
    'mason-org/mason.nvim',
    opts = {},
    config = function()
      require('mason').setup({
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry', --roslyn.nvim
        }
      })
    end
  },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
            },
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {}
      },
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'ts_ls', 'pyright', 'netcoredbg' }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config('lua_ls', {
        capabilities = capabilities
      })
      vim.lsp.config('ts_ls', {
        capabilities = capabilities
      })
      vim.lsp.config('pyright', {
        capabilities = capabilities
      })

      vim.lsp.enable({ 'lua_ls', 'ts_ls', 'pyright' })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  },
  {
    "seblyng/roslyn.nvim",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config('roslyn', {
        capabilities = capabilities,
        settings = {
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicity_variable_types = true,
          },
          ['csharp|code_lens'] = {
            dotnet_enable_reference_code_lens = true,
          },
        }
      })

      require('roslyn').setup({})
    end
  }
}
