MiniDeps.later(function ()
    MiniDeps.add({
        source = "NeogitOrg/neogit",
        depends = {
            "sindrets/diffview.nvim",
        },
    })

    local neogit = require("neogit")

    Angju.map({
        keys = "<leader>gn",
        func = function ()
            neogit.open()
        end,
        desc = "Open [ Neogit ]",
    })
end)
