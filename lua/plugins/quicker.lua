MiniDeps.later(function ()
    MiniDeps.add({
        source = "stevearc/quicker.nvim",
    })

    local quicker = require("quicker")
    quicker.setup({
        keys = {
            {
                ">",
                function ()
                    require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                end,
                desc = "Expand quickfix context",
            },
            {
                "<",
                function ()
                    require("quicker").collapse()
                end,
                desc = "Collapse quickfix context",
            },
        },
    })

    local map = Angju.map

    map({
        keys = "<leader>xq",
        func = function ()
            quicker.toggle()
        end,
        desc = "Toggle Quickfix [Quicker]",
    })

    map({
        keys = "<leader>xc",
        func = function ()
            quicker.toggle({ loclist = true })
        end,
        desc = "Toggle Loclist [Quicker]",
    })
end)
