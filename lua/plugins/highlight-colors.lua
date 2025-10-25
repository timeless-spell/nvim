MiniDeps.later (function ()
    MiniDeps.add ({
        source = "brenoprata10/nvim-highlight-colors",
    })

    require ("nvim-highlight-colors").setup ({
        render = "foreground",
        -- virtual_symbol = '',
        exclude_filetypes = {},
        exclude_buftypes = {},
    })
end)
