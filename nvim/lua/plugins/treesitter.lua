return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local config = require'nvim-treesitter.configs'
      config.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "javascript", "c_sharp" },
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
          disable = { },
         additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end
  }
}
