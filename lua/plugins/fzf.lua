MiniDeps.later(function ()
    MiniDeps.add({
        source = "ibhagwan/fzf-lua",
    })

    local fzf = require("fzf-lua")

    fzf.setup({
        files = {
            previewer = "bat",
        },
    })

    local keymaps = {
        --
        -- Buffers and Files
        --
        { keys = "<leader>ff", func = fzf.files, desc = "Files [Fzf]" },
        {
            keys = "<leader>fx",
            func = function ()
                fzf.files({ cwd = "~" })
            end,
            desc = "Global [Fzf]",
        },
        {
            keys = "<leader>fC",
            func = function ()
                fzf.files({ cwd = "~/.config" })
            end,
            desc = "Config [Fzf]",
        },
        { keys = "<leader>fb", func = fzf.buffers, desc = "Buffers [Fzf]" },
        { keys = "<leader>fo", func = fzf.oldfiles, desc = "Recent files [Fzf]" },
        { keys = "<leader>fq", func = fzf.quickfix, desc = "Quickfix list [Fzf]" },
        { keys = "<leader>fQ", func = fzf.quickfix_stack, desc = "Quickfix stack [Fzf]" },
        { keys = "<leader>fc", func = fzf.loclist, desc = "Loclist list [Fzf]" },
        { keys = "<leader>fC", func = fzf.loclist_stack, desc = "Loclist stack [Fzf]" },
        { keys = "<leader>fn", func = fzf.lines, desc = "Open buffers lines [Fzf]" },
        { keys = "<leader>fN", func = fzf.blines, desc = "Current buffer lines [Fzf]" },
        { keys = "<leader>fT", func = fzf.treesitter, desc = "Current buffer Treesitter symbols [Fzf]" },
        { keys = "<leader>ft", func = fzf.tabs, desc = "Open tabs [Fzf]" },
        { keys = "<leader>fa", func = fzf.args, desc = "Argument list [Fzf]" },

        --
        -- Search
        --
        { keys = "<leader>fwg", func = fzf.grep, desc = "Search pattern [Fzf]" },
        { keys = "<leader>fwl", func = fzf.grep_last, desc = "Search last pattern [Fzf]" },
        { keys = "<leader>fww", func = fzf.grep_cword, desc = "Search word under cursor [Fzf]" },
        { keys = "<leader>fwW", func = fzf.grep_cWORD, desc = "Search WORD under cursor [Fzf]" },
        { keys = "<leader>fwV", func = fzf.grep_visual, desc = "Search visual selection [Fzf]" },
        { keys = "<leader>fwp", func = fzf.grep_project, desc = "Search all project lines [Fzf]" },
        { keys = "<leader>fwb", func = fzf.grep_curbuf, desc = "Search current buffer lines [Fzf]" },
        { keys = "<leader>fwq", func = fzf.grep_quickfix, desc = "Search the quickfix list [Fzf]" },
        { keys = "<leader>fwc", func = fzf.grep_loclist, desc = "Search the loccation list [Fzf]" },

        { keys = "<leader>fwf", func = fzf.lgrep_curbuf, desc = "Live grep curent buffer [Fzf]" },
        { keys = "<leader>fwx", func = fzf.lgrep_quickfix, desc = "Live grep the quickfix list [Fzf]" },
        { keys = "<leader>fws", func = fzf.lgrep_loclist, desc = "Live grep the location list[Fzf]" },
        { keys = "<leader>fwv", func = fzf.live_grep, desc = "Live grep current project [Fzf]" },
        { keys = "<leader>fwr", func = fzf.live_grep_resume, desc = "Live grep last search [Fzf]" },
        { keys = "<leader>fwo", func = fzf.live_grep_glob, desc = "Live grep 'rg --glob' [Fzf]" },
        { keys = "<leader>fwG", func = fzf.live_grep_native, desc = "Live grep native [Fzf]" },

        --
        -- LSP
        --
        { keys = "<leader>flr", func = fzf.lsp_references, desc = "LSP References [Fzf]" },
        { keys = "<leader>fld", func = fzf.lsp_definitions, desc = "LSP Definitions [Fzf]" },
        { keys = "<leader>flD", func = fzf.lsp_declarations, desc = "LSP Declarations [Fzf]" },
        { keys = "<leader>flt", func = fzf.lsp_typedefs, desc = "LSP Type Definitions [Fzf]" },
        { keys = "<leader>fli", func = fzf.lsp_implementations, desc = "LSP Implementations [Fzf]" },
        { keys = "<leader>fls", func = fzf.lsp_document_symbols, desc = "LSP Document Symbols [Fzf]" },
        { keys = "<leader>flw", func = fzf.lsp_workspace_symbols, desc = "LSP Workspace Symbols [Fzf]" },
        { keys = "<leader>flW", func = fzf.lsp_live_workspace_symbols, desc = "LSP Workspace Symbols (live query) [Fzf]" },
        { keys = "<leader>fla", func = fzf.lsp_code_actions, desc = "LSP Code Actions [Fzf]" },
        { keys = "<leader>flF", func = fzf.lsp_finder, desc = "LSP Locations, combined view [Fzf]" },
        { keys = "<leader>flg", func = fzf.lsp_document_diagnostics, desc = "LSP Diagnostics Document [Fzf]" },
        { keys = "<leader>flG", func = fzf.lsp_workspace_diagnostics, desc = "LSP Diagnostics Workspace [Fzf]" },

        --
        -- Zoxide
        --
        { keys = "<leader>fZ", func = fzf.zoxide, desc = "Zoxide [Fzf]" },
    }

    Angju.multi_map(keymaps)
end)
