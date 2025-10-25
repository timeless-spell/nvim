MiniDeps.later (function ()
    MiniDeps.add ({
        source = "neovim/nvim-lspconfig",
    })

    MiniDeps.add ({
        source = "nvim-lua/plenary.nvim",
    })
end)

MiniDeps.now (function ()
    MiniDeps.add ({
        source = "nvim-tree/nvim-web-devicons",
    })
end)
