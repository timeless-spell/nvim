vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function (event)
        ---@type angju.Keymap[]
        local keymaps = {
            { keys = "<leader>lgd", func = vim.lsp.buf.definition, desc = "LSP: [G]oto [D]efinition", buffer = event.buf },
            { keys = "<leader>lgD", func = vim.lsp.buf.declaration, desc = "LSP: [G]oto [D]eclaration", buffer = event.buf },
            { keys = "<leader>lgi", func = vim.lsp.buf.implementation, desc = "LSP: [G]oto Implementation", buffer = event.buf },
            { keys = "<leader>lgt", func = vim.lsp.buf.type_definition, desc = "LSP: [G]oto [T]ype Definition", buffer = event.buf },
            { keys = "<leader>lh", func = vim.lsp.buf.signature_help, desc = "LSP: Signature [H]elp", buffer = event.buf },
            { keys = "<leader>lr", func = vim.lsp.buf.references, desc = "LSP: [R]eferences", buffer = event.buf },
            { keys = "<leader>ln", func = vim.lsp.buf.rename, desc = "LSP: Re[n]ame,", buffer = event.buf },
            { keys = "<leader>la", func = vim.lsp.buf.code_action, desc = "LSP: Code [A]ction", buffer = event.buf },
            { keys = "<leader>lw", func = vim.lsp.buf.workspace_symbol, desc = "LSP: [W]orkspace Symbol", buffer = event.buf },
            { keys = "<leader>ld", func = vim.lsp.buf.document_symbol, desc = "LSP: [D]ocument Symbol", buffer = event.buf },
        }

        Angju.multi_map(keymaps)

        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method (client, method, bufnr)
            return client:supports_method(method, bufnr)
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
                desc = "Highlight word under cursor.",
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                callback = function (event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                end,
            })
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textdocument_inlayhint, event.buf) then
            Angju.map({
                keys = "<leader>lH",
                func = function ()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                end,
                desc = "Toggle Inlay [H]ints",
            })
        end
    end,
})
