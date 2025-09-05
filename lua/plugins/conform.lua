MiniDeps.later (function ()
  MiniDeps.add ({
    source = 'stevearc/conform.nvim',
  })

  require ('conform').setup ({
    formatters_by_ft = {
      lua = { 'stylua' },
    },
    format_after_save = {
      timeout_ms = 500,
    },
  })
end)
