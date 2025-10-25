MiniDeps.later (function ()
    MiniDeps.add ({
        source = "shellRaining/hlchunk.nvim",
    })

    require ("hlchunk").setup ({
        chunk = {
            enable = true,
            exclude_filetypes = {
                "help",
            },
        },
        blank = {
            enable = true,
            chars = {
                " ",
            },
            style = {
                { bg = vim.fn.synIDattr (vim.fn.synIDtrans (vim.fn.hlID ("cursorline")), "bg", "gui") },
                { bg = "", fg = "" },
            },
        },
        -- line_num = {
        --   enable = true,
        --   style = '#45ba32',
        --   priority = 10,
        --   use_treesitter = false,
        -- },
    })
end)
