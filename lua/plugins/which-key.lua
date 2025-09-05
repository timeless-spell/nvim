MiniDeps.later (function ()
  MiniDeps.add ({
    source = 'folke/which-key.nvim',
  })

  local wk = require ('which-key')

  wk.setup ({
    preset = 'helix',
  })

  wk.add ({
    { '<leader>t', group = 'Telescope', icon = '󰭎' },
    { '<leader>tl', group = 'LSP', icon = '' },
    { '<leader>m', group = 'Mini', icon = '󰨅' },
    { '<leader>x', group = 'Trouble', icon = '󱈎' },
    { '<leader>g', group = 'Git', icon = '' },
    { '<leader>ge', group = 'Export', icon = '' },
    { '<leader>f', group = 'FzfLua', icon = '󰍉' },
    { '<leader>fw', group = 'Grep', icon = '󰍉' },
    -- { '<leader>fg', group = 'Git', icon = '󰍉' },
    { '<leader>fl', group = 'LSP', icon = '󰍉' },
    { '<leader>l', group = 'LSP', icon = '󰒋' },
    { '<leader>lg', group = 'Go to', icon = '󰒋' },
    { '<leader>d', group = 'Diagnostics', icon = '' },
    -- { '<leader>D', group = 'DAP', icon = '' },
    -- { '<leader>r', group = 'Resession', icon = '󰹑' },
    { '\\', group = 'FFF', icon = '󰧶' },
    { '<leader>b', group = 'Buffer', icon = '󰯉' },
  })

  Angju.map ('<leader>\\', function ()
    wk.show ({ global = false })
  end, 'Which-Key: Buffer Local Keymaps')
end)
