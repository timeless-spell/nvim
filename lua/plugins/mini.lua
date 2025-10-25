local map = Angju.map

local now, later = MiniDeps.now, MiniDeps.later

--
-- MiniIcons:
--
-- now (function ()
--   require ('mini.icons').setup ()
-- end)

--
-- MiniStatus:
--
now (function ()
    require ("mini.statusline").setup ()
end)

--
-- MiniFiles:
--
now (function ()
    require ("mini.files").setup ({
        options = { use_as_default_explorer = false },
    })

    vim.api.nvim_set_hl (0, "NormalFloat", { bg = "none" })

    map ("<leader>mf", "<cmd>lua MiniFiles.open()<cr>", "Open MiniFiles")
end)

--
-- MiniPairs:
--
later (function ()
    require ("mini.pairs").setup ()
end)

--
-- MiniBufremove
--
later (function ()
    require ("mini.bufremove").setup ()
end)

--
-- MiniExtra
--
later (function ()
    require ("mini.extra").setup ()
end)

--
-- MiniPick:
--
later (function ()
    require ("mini.pick").setup ()
    map ("<leader>msf", "<cmd>lua MiniPick.builtin.files()<cr>", "Files [MiniPick]")
    map ("<leader>msb", "<cmd>lua MiniPick.builtin.buffers()<cr>", "Buffers [MiniPick]")
end)

--
-- MiniAi:
--
later (function ()
    local spec_treesitter = require ("mini.ai").gen_spec.treesitter
    local gen_ai_spec = require ("mini.extra").gen_ai_spec
    require ("mini.ai").setup ({
        custom_textobjects = {
            F = spec_treesitter ({ a = "@function.outer", i = "@function.inner" }),
            o = spec_treesitter ({
                a = { "@conditional.outer", "@loop.outer" },
                i = { "@conditional.inner", "@loop.inner" },
            }),
            C = spec_treesitter ({ a = "@comment.outer", i = "@comment.inner" }),
            B = gen_ai_spec.buffer (),
            D = gen_ai_spec.diagnostic (),
            I = gen_ai_spec.indent (),
            L = gen_ai_spec.line (),
            N = gen_ai_spec.number (),
        },
    })
end)

--
-- MiniComment:
--
later (function ()
    require ("mini.comment").setup ()
end)

--
-- MiniCursorword:
--
later (function ()
    require ("mini.cursorword").setup ()
end)

--
-- MiniMove:
--
later (function ()
    require ("mini.move").setup ()
end)

--
-- MiniSurround:
--
later (function ()
    require ("mini.surround").setup ({
        mappings = {
            add = "msa",
            delete = "msd",
            find = "msf",
            find_left = "msF",
            highlight = "msh",
            replace = "msr",
            update_n_lines = "msn",

            suffix_last = "l",
            suffix_next = "n",
        },
    })
end)

--
-- MiniDiff
--
later (function ()
    require ("mini.diff").setup ({
        mappings = {
            apply = "mgh",
            reset = "mgH",
            textobject = "mgh",
        },
        view = {
            style = "sign",
            signs = { add = "", change = "", delete = "" },
        },
    })

    map ("<leader>gd", MiniDiff.toggle_overlay, "Toggle Overlay [MiniDiff]")
    map ("<leader>gea", function ()
        vim.fn.setqflist (MiniDiff.export ("qf"))
    end, "Export All [MiniDiff]")
    map ("<leader>gec", function ()
        vim.fn.setqflist (MiniDiff.export ("qf", { scope = "current" }))
    end, "Export Current [MiniDiff]")
end)

--
-- MiniGit
--
later (function ()
    require ("mini.git").setup ()
end)
