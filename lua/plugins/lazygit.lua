MiniDeps.later(function ()
    MiniDeps.add({
        source = "kdheepak/lazygit.nvim",
    })

    Angju.map({ keys = "<leader>gl", func = "<cmd>LazyGit<cr>", desc = "LazyGit" })
end)
