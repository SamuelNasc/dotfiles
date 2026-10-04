return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      -- 'enter' preset: <CR> accepts, <C-Space> opens, <C-e> closes, <C-b>/<C-f> scroll docs
      keymap = { preset = 'enter' },
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        menu = { border = 'rounded' },
        documentation = { auto_show = true, window = { border = 'rounded' } },
      },
      signature = { enabled = true, window = { border = 'rounded' } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
