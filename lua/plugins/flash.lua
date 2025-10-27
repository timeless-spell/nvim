MiniDeps.later(function ()
    MiniDeps.add({
        source = "folke/flash.nvim",
    })

    local map = Angju.map

    local keymaps = {
        {
            keys = "s",
            func = function ()
                require("flash").jump()
            end,
            desc = "Jump [Flash]",
            mode = { "n", "x", "o" },
        },
        {
            keys = "S",
            func = function ()
                require("flash").treesitter()
            end,
            desc = "Treesitter [Flash]",
            mode = { "n", "x", "o" },
        },
        {
            keys = "r",
            func = function ()
                require("flash").remote()
            end,
            desc = "Remote [Flash]",
            "o",
        },
        {
            keys = "R",
            func = function ()
                require("flash").treesitter_search()
            end,
            desc = "Treesitter Search [Flash]",
            mode = { "o", "x" },
        },
        {
            keys = "<c-s>",
            func = function ()
                require("flash").toggle()
            end,
            desc = "Toggle Search [Flash]",
            mode = { "c" },
        },
    }

    Angju.multi_map(keymaps)
end)
