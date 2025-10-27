---@type vim.diagnostic.Opts
local diagnostic_config = {
    severity_sort = true,
    float = { header = " Diagnostics ", border = "none", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    } or {},
    virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function (diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}

vim.diagnostic.config(diagnostic_config)

local diagnostics_visible = true

local function toggleDiagnostics ()
    if diagnostics_visible then
        vim.diagnostic.hide()
        diagnostics_visible = false
    else
        vim.diagnostic.show()
        diagnostics_visible = true
    end
end

local keymaps = {
    { keys = "<leader>dl", func = vim.diagnostic.setloclist, desc = "Open diagnostic [L]ocation list" },
    { keys = "<leader>dq", func = vim.diagnostic.setqflist, desc = "Open diagnostic [Q]uickfix list" },
    { keys = "<leader>df", func = vim.diagnostic.open_float, desc = "Open diagnostic [F]loat" },
    { keys = "<leader>dt", func = toggleDiagnostics, desc = "Hide/Show diagnostic" },
}
Angju.multi_map(keymaps)
