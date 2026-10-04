return {
  {
    'mason-org/mason.nvim',
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
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'ts_ls', 'pyright', 'ruff', 'tailwindcss', 'eslint' }
      })
    end
  },
  {
    -- non-LSP tools (debuggers, formatters) and roslyn, which mason-lspconfig doesn't know about
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = { 'roslyn', 'netcoredbg', 'debugpy', 'stylua' }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities()
      })

      vim.lsp.enable({ 'lua_ls', 'ts_ls', 'pyright', 'ruff', 'tailwindcss', 'eslint' })

      -- Neovim 0.11+ no longer shows diagnostics as inline text by default
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        float = { border = 'rounded', source = true },
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
    end
  },
  {
    "seblyng/roslyn.nvim",
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      vim.lsp.config('roslyn', {
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
