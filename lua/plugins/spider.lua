MiniDeps.later (function ()
    MiniDeps.add ({
        source = "chrisgrieser/nvim-spider",
    })

    local spider = require ("spider")
    spider.setup ({})

    local map = Angju.map

    map ("e", function ()
        spider.motion ("e")
    end, "Spider [e]", { "n", "x", "o" })

    map ("w", function ()
        spider.motion ("w")
    end, "Spider [w]", { "n", "x", "o" })

    map ("b", function ()
        spider.motion ("b")
    end, "Spider [b]", { "n", "x", "o" })
end)
