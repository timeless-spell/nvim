MiniDeps.later(function ()
    MiniDeps.add({
        source = "gbprod/substitute.nvim",
    })

    local subs = require("substitute")

    subs.setup({
        on_substitute = function ()
            require("yanky.integration").substitute()
        end,
    })

    local keymaps = {
        { keys = "<leader>so", func = subs.operator, desc = "Operator [Substitute]" },
        { keys = "<leader>sl", func = subs.line, desc = "Operator [Substitute]" },
        { keys = "<leader>se", func = subs.eol, desc = "End of Line [Substitute]" },
        { keys = "<leader>sx", func = subs.visual, desc = "Visual [Substitute]", mode = "x" },
        { keys = "<leader>sr", func = require("substitute.range").operator, desc = "Operator Range [Substitute]" },
        { keys = "<leader>sX", func = require("substitute.range").visual, desc = "Visual Range [Substitute]", mode = "x" },
        { keys = "<leader>sw", func = require("substitute.range").word, desc = "Word Range [Substitute]" },
        { keys = "<leader>sR", func = require("substitute.exchange").operator, desc = "Exchange Operator [Substitute]" },
        { keys = "<leader>sL", func = require("substitute.exchange").line, desc = "Exchange Line [Substitute]" },
        { keys = "<leader>sv", func = require("substitute.exchange").visual, desc = "Exchange Line [Substitute]", mode = "x" },
        { keys = "<leader>sq", func = require("substitute.exchange").cancel, desc = "Exchange Cancel [Substitute]" },
    }

    Angju.multi_map(keymaps)
end)
