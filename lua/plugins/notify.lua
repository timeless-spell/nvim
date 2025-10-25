MiniDeps.now (function ()
    MiniDeps.add ({
        source = "rcarriga/nvim-notify",
        -- depends = {
        --   'j-hui/fidget.nvim',
        -- },
    })

    local notify = require ("notify")

    notify.setup ({
        stager = "fade",
        timeout = 2000,
    })
end)
