MiniDeps.now(function ()
    MiniDeps.add({
        source = "rcarriga/nvim-notify",
    })

    local notify = require("notify")

    notify.setup({
        stager = "fade",
        timeout = 2000,
    })

    vim.notify = require("notify")
end)
