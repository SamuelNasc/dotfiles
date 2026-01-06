return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = ':Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = ':Telescope builtin',
            key = 'a',
          },
          {
            desc = ' Dotfiles',
            group = 'Number',
            action = ':Telescope find_files cwd=~/.config/nvim hidden=true',
            key = 'd',
          },
        },
      },
    }
  end,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' }
  }
}
