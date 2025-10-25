vim.diagnostic.config ({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
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
})

local map = Angju.map

map ("<leader>dl", vim.diagnostic.setloclist, "Open diagnostic [L]ocation list")
map ("<leader>dq", vim.diagnostic.setqflist, "Open diagnostic [Q]uickfix list")
map ("<leader>df", vim.diagnostic.open_float, "Open diagnostic [F]loat")

local diagnostics_visible = true

local function toggleDiagnostics ()
    if diagnostics_visible then
        vim.diagnostic.hide ()
        diagnostics_visible = false
    else
        vim.diagnostic.show ()
        diagnostics_visible = true
    end
end
map ("<leader>dt", toggleDiagnostics, "Hide/Show diagnostic")
