return {
  'nvimtools/none-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    border = 'rounded',
  },
  config = function()
    local null = require('null-ls')
    null.setup({
      sources = {
        null.builtins.diagnostics.luacheck.with({
          extra_args = { '--globals', 'vim' },
        }),
        null.builtins.diagnostics.shellcheck,
        null.builtins.diagnostics.stylelint,
      },
    })
  end,
}
