MiniDeps.later (function ()
  MiniDeps.add ({
    source = 'stevearc/quicker.nvim',
  })

  local quicker = require ('quicker')
  quicker.setup ({
    keys = {
      {
        '>',
        function ()
          require ('quicker').expand ({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = 'Expand quickfix context',
      },
      {
        '<',
        function ()
          require ('quicker').collapse ()
        end,
        desc = 'Collapse quickfix context',
      },
    },
  })

  local map = Angju.map

  map ('<leader>xq', function ()
    quicker.toggle ()
  end, 'Toggle Quickfix [Quicker]')

  map ('<leader>xc', function ()
    quicker.toggle ({ loclist = true })
  end, 'Toggle Loclist [Quicker]')
end)
