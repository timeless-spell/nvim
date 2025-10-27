MiniDeps.later(function ()
    MiniDeps.add({
        source = "stevearc/resession.nvim",
    })

    local res = require("resession")

    res.setup({})

    local keymaps = {
        { keys = "<leader>rs", func = res.save, desc = "Save session [Resession]" },
        { keys = "<leader>rl", func = res.load, desc = "Load session [Resession]" },
        { keys = "<leader>rd", func = res.delete, desc = "Delete session [Resession]" },
    }
    Angju.multi_map(keymaps)

    local resession_group = vim.api.nvim_create_augroup("resession", { clear = true })

    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = resession_group,
        callback = function ()
            res.save("last")
        end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
        group = resession_group,
        callback = function ()
            -- Only load the session if nvim was started with no args and without reading from stdin
            if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
                -- Save these to a different directory, so our manual sessions don't get polluted
                res.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
            end
        end,
        nested = true,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = resession_group,
        callback = function ()
            res.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
        end,
    })

    vim.api.nvim_create_autocmd("StdinReadPre", {
        group = resession_group,
        callback = function ()
            -- Store this for later
            vim.g.using_stdin = true
        end,
    })
end)
