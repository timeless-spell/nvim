MiniDeps.later(function ()
    MiniDeps.add({
        source = "gbprod/yanky.nvim",
    })

    require("yanky").setup({
        highlight = {
            on_put = true,
            on_yank = false,
            timer = 500,
        },
        preserve_cursor_position = {
            enabled = true,
        },
        on_substitute = function ()
            require("yanky.integration").substitute()
        end,
    })

    local keymaps = {
        { keys = "p", func = "<Plug>(YankyPutAfter)", desc = "Put After [Yanky]", mode = { "n", "x" } },
        { keys = "P", func = "<Plug>(YankyPutBefore)", desc = "Put Before [Yanky]", mode = { "n", "x" } },
        { keys = "gp", func = "<Plug>(YankyGPutAfter)", desc = "GPut Ater [Yanky]", mode = { "n", "x" } },
        { keys = "gP", func = "<Plug>(YankyGPutBefore)", desc = "GPut Before [Yanky]", mode = { "n", "x" } },
        { keys = "y", func = "<Plug>(YankyYank)", desc = "Yank [Yanky]", mode = { "n", "x" } },
        { keys = "<a-[>", func = "<Plug>(YankyPreviousEntry)", desc = "Previous Entry [Yanky]" },
        { keys = "<a-]>", func = "<Plug>(YankyNextEntry)", desc = "Next Entry [Yanky]" },
        { keys = "]p", func = "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indent After Line [Yanky]" },
        { keys = "[p", func = "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indent Before Line [Yanky]" },
        { keys = "]P", func = "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indent After Line [Yanky]" },
        { keys = "[P", func = "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indent Before Line [Yanky]" },
        { keys = ">p", func = "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put Indent After Shift Right [Yanky]" },
        { keys = "<p", func = "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put Indent After Shift Left [Yanky]" },
        { keys = ">P", func = "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Indent Before Shift Right [Yanky]" },
        { keys = "<P", func = "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Indent Before Shift Left [Yanky]" },
        { keys = "=p", func = "<Plug>(YankyPutAfterFilter)", desc = "Put After Filter [Yanky]" },
        { keys = "=P", func = "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Filter [Yanky]" },
        {
            keys = "<leader>ty",
            func = function ()
                require("telescope").extensions.yank_history.yank_history({
                    previewer = false,
                    layout_strategy = "cursor",
                    layout_config = {
                        height = 0.3,
                        width = 0.4,
                    },
                })
            end,
            desc = "Yanky History [Telescope]",
        },
    }

    Angju.multi_map(keymaps)
end)
