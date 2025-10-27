MiniDeps.later(function ()
    local function build_fff_async (params)
        vim.notify("Building FFF...", vim.log.levels.INFO)

        vim.system(
            { "cargo", "build", "--release" },
            { text = true, cwd = params.path },
            vim.schedule_wrap(function (result)
                if result.code ~= 0 then
                    vim.notify("Building FFF failed \n" .. (result.stderr or result.stdout or ""), vim.log.levels.ERROR)
                else
                    vim.notify("Building FFF completed successfully ✔️", vim.log.levels.INFO)
                end
            end)
        )
    end

    MiniDeps.add({
        source = "dmtrKovalenko/fff.nvim",
        hooks = {
            post_install = build_fff_async,
            post_checkout = build_fff_async,
        },
    })

    local fff = require("fff")
    fff.setup({
        prompt = " ",
    })

    local keymaps = {
        {
            keys = "\\ff",
            func = function ()
                fff.find_files()
            end,
            desc = "Find files in current directory [FFF].",
        },
        {
            keys = "\\fs",
            func = function ()
                fff.scan_files()
            end,
            desc = "Rescan of files in current directory [FFF].",
        },
        {
            keys = "\\fg",
            func = function ()
                fff.find_in_git_root()
            end,
            desc = "Find files in current git repository [FFF].",
        },
    }

    Angju.multi_map(keymaps)
end)
