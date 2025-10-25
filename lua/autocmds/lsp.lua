local map = Angju.map
local mapb = Angju.bmap

vim.api.nvim_create_autocmd ("LspAttach", {
    group = vim.api.nvim_create_augroup ("lsp-attach", { clear = true }),
    callback = function (event)
        mapb ("<leader>lgd", vim.lsp.buf.definition, "LSP: [G]oto [D]efinition", event.buf)
        mapb ("<leader>lgD", vim.lsp.buf.declaration, "LSP: [G]oto [D]eclaration", event.buf)
        mapb ("<leader>lgi", vim.lsp.buf.implementation, "LSP: [G]oto Implementation", event.buf)
        mapb ("<leader>lgt", vim.lsp.buf.type_definition, "LSP: [G]oto [T]ype Definition", event.buf)
        mapb ("<leader>lh", vim.lsp.buf.signature_help, "LSP: Signature [H]elp", event.buf)
        mapb ("<leader>lr", vim.lsp.buf.references, "LSP: [R]eferences", event.buf)
        mapb ("<leader>ln", vim.lsp.buf.rename, "LSP: Re[n]ame,", event.buf)
        mapb ("<leader>la", vim.lsp.buf.code_action, "LSP: Code [A]ction", event.buf)
        mapb ("<leader>lw", vim.lsp.buf.workspace_symbol, "LSP: [W]orkspace Symbol", event.buf)
        mapb ("<leader>ld", vim.lsp.buf.document_symbol, "LSP: [D]ocument Symbol", event.buf)

        local function client_supports_method (client, method, bufnr)
            return client:supports_method (method, bufnr)
        end

        local client = vim.lsp.get_client_by_id (event.data.client_id)
        if client and client_supports_method (client, vim.lsp.protocol.Methods.textdocument_documenthighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup ("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd ({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
                desc = "Highlight word under cursor.",
            })

            vim.api.nvim_create_autocmd ({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd ("LspDetach", {
                group = vim.api.nvim_create_augroup ("lsp-detach", { clear = true }),
                callback = function (event2)
                    vim.lsp.buf.clear_references ()
                    vim.api.nvim_clear_autocmds ({ group = "lsp-highlight", buffer = event2.buf })
                end,
            })
        end

        if client and client_supports_method (client, vim.lsp.protocol.Methods.textdocument_inlayhint, event.buf) then
            map ("<leader>lth", function ()
                vim.lsp.inlay_hint.enable (not vim.lsp.inlay_hint.is_enabled ({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})
