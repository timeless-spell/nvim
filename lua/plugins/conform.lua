MiniDeps.later(function ()
    MiniDeps.add({
        source = "stevearc/conform.nvim",
    })

    require("conform").setup({
        formatters_by_ft = {
            lua = { "stylua" },
            html = { "biome" },
            css = { "biome" },
            javascript = { "biome", "denofmt", stop_after_first = true },
            typescript = { "biome", "denofmt", stop_after_first = true },
        },
        format_after_save = {
            timeout_ms = 500,
        },
    })
end)
