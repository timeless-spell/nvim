MiniDeps.later(function ()
    MiniDeps.add {
        source = 'NeogitOrg/neogit',
        depends = {
            'sindrets/diffview.nvim',
        },
    }

    local neogit = require 'neogit'

    Angju.set_keymap('<leader>gn', function ()
        neogit.open()
    end, 'Open [ Neogit ]')
end)
