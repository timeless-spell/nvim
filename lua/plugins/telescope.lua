MiniDeps.later(function ()
    local function build_fzf_native (params)
        vim.notify("Building: FZF Native", vim.log.levels.INFO)

        vim.system(
            { "make" },
            { text = true, cwd = params.path },
            vim.schedule_wrap(function (result)
                if result.code ~= 0 then
                    vim.notify("Building: FZF Native failed \n" .. (result.stderr or result.stdout or ""), vim.log.levels.ERROR)
                else
                    vim.notify("Building: FZF Native completed successfully ✔️", vim.log.levels.INFO)
                end
            end)
        )
    end

    MiniDeps.add({
        source = "nvim-telescope/telescope-fzf-native.nvim",
        hooks = {
            post_install = build_fzf_native,
            post_checkout = build_fzf_native,
        },
    })

    MiniDeps.add({
        source = "nvim-telescope/telescope.nvim",
        checkout = "master",
        depends = {
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "jvgrootveld/telescope-zoxide",
        },
    })

    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local utils = require("telescope.utils")

    local telescope_config = {
        defaults = {
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                },
            },
            prompt_prefix = "󰍉 ",
            selection_caret = "󰜴 ",
            entry_prefix = " ",
            multi_icon = " ",
            mappings = {
                i = {
                    ["<c-down>"] = actions.cycle_history_next,
                    ["<c-up>"] = actions.cycle_history_prev,
                    ["<c-q>"] = actions.close,
                },
            },
        },
        extensions = {
            ["file_browser"] = {
                path = "%:p:h",
                cwd_to_path = true,
                layout_strategy = "center",
                layout_config = { height = 0.8, width = 0.8 },
                previewer = false,
                hijack_netrw = true,
                hidden = {
                    file_browser = true,
                    folder_browser = true,
                },
            },
            ["ui-select"] = require("telescope.themes").get_dropdown(),
            ["fzf"] = {},
            ["zoxide"] = {
                mappings = {
                    ["<C-b>"] = {
                        keepinsert = true,
                        action = function (selection)
                            require("telescope").extensions.file_browser.file_browser({
                                cwd = selection.path,
                            })
                        end,
                    },
                },
            },
        },
    }

    telescope.setup(telescope_config)

    for extension, _ in pairs(telescope_config.extensions) do
        pcall(require("telescope").load_extension, extension)
    end

    ---@type angju.Keymap
    local keymaps = {
        {
            keys = "<leader>tf",
            func = function ()
                builtin.find_files({ hidden = true, layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 } })
            end,
            desc = "Search [F]iles",
        },
        {
            keys = "<leader>tc",
            func = function ()
                builtin.find_files({
                    cwd = utils.buffer_dir(),
                    hidden = true,
                    layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 },
                })
            end,
            desc = "Search Files ([c]urrent buffer)",
        },
        {
            keys = "<leader>to",
            func = function ()
                builtin.oldfiles({
                    previewer = false,
                    layout_strategy = "vertical",
                    layout_config = { prompt_position = "top", width = 0.9 },
                })
            end,
            desc = "Search [O]ld Files",
        },
        {
            keys = "<leader>tg",
            func = function ()
                builtin.live_grep({
                    layout_strategy = "vertical",
                    layout_config = {
                        prompt_position = "bottom",
                        width = 0.95,
                        height = 0.95,
                    },
                })
            end,
            desc = "Search by [G]rep",
        },
        {
            keys = "<leader>tg",
            func = function ()
                builtin.live_grep({
                    layout_strategy = "vertical",
                    layout_config = {
                        prompt_position = "bottom",
                        width = 0.95,
                        height = 0.95,
                    },
                })
            end,
            desc = "Search by [G]rep",
        },
        {
            keys = "<leader>tw",
            func = function ()
                builtin.grep_string({
                    layout_strategy = "vertical",
                    layout_config = {
                        prompt_position = "bottom",
                        width = 0.95,
                        height = 0.95,
                    },
                })
            end,
            desc = "Search current [W]ord",
        },
        {
            keys = "<leader>t/",
            func = function ()
                builtin.current_buffer_fuzzy_find({
                    layout_strategy = "center",
                    windblend = 10,
                    previewer = false,
                    layout_config = { width = 0.6, height = 0.55 },
                })
            end,
            desc = "[/] Fuzzily search in current buffer",
        },
        {
            keys = "<leader>tq",
            func = function ()
                builtin.quickfix({
                    layout_strategy = "center",
                    prompt_position = "bottom",
                    layout_config = { width = 0.75 },
                    previewer = false,
                })
            end,
            desc = "[Q]uiqfix",
        },
        {
            keys = "<leader>t<leader>",
            func = function ()
                builtin.buffers({
                    previewer = false,
                    layout_strategy = "center",
                    layout_config = { height = 0.5, width = 0.7 },
                })
            end,
            desc = "Search Open Buffers",
        },
        {
            keys = "<leader>th",
            func = function ()
                builtin.help_tags({
                    layout_strategy = "bottom_pane",
                    layout_config = {
                        prompt_position = "bottom",
                        height = 0.8,
                        preview_width = 0.7,
                    },
                })
            end,
            desc = "Search [H]elp",
        },
        {
            keys = "<leader>tn",
            func = function ()
                builtin.find_files({
                    cwd = vim.fn.stdpath("config"),
                    previewer = false,
                    layout_strategy = "center",
                    layout_config = { height = 0.7 },
                })
            end,
            desc = "Search [N]eovim Files",
        },
        {
            keys = "<leader>tk",
            func = function ()
                builtin.keymaps({
                    layout_strategy = "center",
                    layout_config = { width = 0.7, height = 0.6 },
                })
            end,
            desc = "[S]earch [K]eymaps",
        },
        {
            keys = "<leader>tb",
            func = function ()
                telescope.extensions.file_browser.file_browser({
                    cwd = vim.fn.expand("%:p:h"),
                    layout_strategy = "horizontal",
                    layout_config = {
                        height = 0.95,
                        prompt_position = "top",
                        width = 0.95,
                        preview_width = 0.60,
                    },
                    grouped = true,
                    -- depth = 2,
                    hidden = {
                        file_browser = true,
                        folder_browser = true,
                    },
                    respect_gitignore = false,
                    previewer = true,
                })
            end,
            desc = "File [B]rowser",
        },
        {
            keys = "<leader>tz",
            func = function ()
                require("telescope").extensions.zoxide.list({
                    layout_config = { width = 0.9, height = 0.7, preview_width = 0.5 },
                })
            end,
            desc = "Zoxide [Telescope]",
        },
    }
    Angju.multi_map(keymaps)

    -- map("<leader>tf", function ()
    --     builtin.find_files({
    --         hidden = true,
    --         layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 },
    --     })
    -- end, "Search [F]iles")

    -- search files in the buffer's current working directory
    -- map("<leader>tc", function ()
    --     builtin.find_files({
    --         cwd = utils.buffer_dir(),
    --         hidden = true,
    --         layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 },
    --     })
    -- end, "Search Files ([c]urrent buffer)")

    -- Old files:
    -- search recently open files `:h telescope.builtin.oldfiles`
    -- map("<leader>to", function ()
    --     builtin.oldfiles({
    --         previewer = false,
    --         layout_strategy = "vertical",
    --         layout_config = { prompt_position = "top", width = 0.9 },
    --     })
    -- end, "Search [O]ld Files")

    -- Live grep:
    -- `h: telescope.builtin.live_grep`
    -- map("<leader>tg", function ()
    --     builtin.live_grep({
    --         layout_strategy = "vertical",
    --         layout_config = {
    --             prompt_position = "bottom",
    --             width = 0.95,
    --             height = 0.95,
    --         },
    --     })
    -- end, "Search by [G]rep")

    -- Search word under cursor:
    -- `:h telescope.builtin.grep_string`
    -- map("<leader>tw", function ()
    --     builtin.grep_string({
    --         layout_strategy = "vertical",
    --         layout_config = {
    --             prompt_position = "bottom",
    --             width = 0.95,
    --             height = 0.95,
    --         },
    --     })
    -- end, "Search current [W]ord")

    -- Fuzzy search in buffer:
    -- `:h telescope.builtin.current_buffer_fuzzy_find`
    -- map("<leader>t/", function ()
    --     builtin.current_buffer_fuzzy_find({
    --         layout_strategy = "center",
    --         windblend = 10,
    --         previewer = false,
    --         layout_config = { width = 0.6, height = 0.55 },
    --     })
    -- end, "[/] Fuzzily search in current buffer")

    -- Open telescope file browser (Extension):
    -- `:h telescope-file-browser`
    -- map("<leader>tb", function ()
    --     telescope.extensions.file_browser.file_browser({
    --         cwd = vim.fn.expand("%:p:h"),
    --         layout_strategy = "horizontal",
    --         layout_config = {
    --             height = 0.95,
    --             prompt_position = "top",
    --             width = 0.95,
    --             preview_width = 0.60,
    --         },
    --         grouped = true,
    --         -- depth = 2,
    --         hidden = {
    --             file_browser = true,
    --             folder_browser = true,
    --         },
    --         respect_gitignore = false,
    --         previewer = true,
    --     })
    -- end, "File [B]rowser")

    -- [[ Neovim related keymaps ]]
    -- Open quickfix:
    -- `:h telescope.builtin.quickfix`
    -- map("<leader>tq", function ()
    --     builtin.quickfix({
    --         layout_strategy = "center",
    --         prompt_position = "bottom",
    --         layout_config = { width = 0.75 },
    --         previewer = false,
    --     })
    -- end, "[Q]uiqfix")

    -- Search open existing buffers:
    -- `:h telescope.builtin.buffers`
    -- map("<leader>t<leader>", function ()
    --     builtin.buffers({
    --         previewer = false,
    --         layout_strategy = "center",
    --         layout_config = { height = 0.5, width = 0.7 },
    --     })
    -- end, "Search Open Buffers")

    -- Search help tags:
    -- map("<leader>th", function ()
    --     builtin.help_tags({
    --         layout_strategy = "bottom_pane",
    --         layout_config = {
    --             prompt_position = "bottom",
    --             height = 0.8,
    --             preview_width = 0.7,
    --         },
    --     })
    -- end, "Search [H]elp")

    -- Search Neovim config files:
    -- map("<leader>tn", function ()
    --     builtin.find_files({
    --         cwd = vim.fn.stdpath("config"),
    --         previewer = false,
    --         layout_strategy = "center",
    --         layout_config = { height = 0.7 },
    --     })
    -- end, "Search [N]eovim Files")

    -- Search keymaps:
    -- `:h telescope.builtin.keymaps`
    -- map("<leader>tk", function ()
    --     builtin.keymaps({
    --         layout_strategy = "center",
    --         layout_config = { width = 0.7, height = 0.6 },
    --     })
    -- end, "[S]earch [K]eymaps")

    -- map("<leader>tz", function ()
    --     require("telescope").extensions.zoxide.list({
    --         layout_config = { width = 0.9, height = 0.7, preview_width = 0.5 },
    --     })
    -- end, "Zoxide [Telescope]")

    --     vim.api.nvim_create_autocmd("LspAttach", {
    --         group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
    --         callback = function (event)
    --             mapb("<leader>tld", function ()
    --                 builtin.lsp_definitions({
    --                     layout_config = { width = 0.95, height = 0.95 },
    --                 })
    --             end, "[L]SP [D]efinitions", event.buf)
    --
    --             mapb("<leader>tlr", function ()
    --                 builtin.lsp_references({
    --                     layout_strategy = "vertical",
    --                     layout_config = { width = 0.95, height = 0.95 },
    --                 })
    --             end, "[L]SP [R]eferences", event.buf)
    --
    --             mapb("<leader>tlI", function ()
    --                 builtin.lsp_implementations({
    --                     layout_strategy = "vertical",
    --                     layout_config = { width = 0.95, height = 0.95 },
    --                 })
    --             end, "[L]SP [I]mplementation", event.buf)
    --
    --             mapb("<leader>tlD", builtin.lsp_type_definitions, "[L]SP Type [D]efinition", event.buf)
    --
    --             mapb("<leader>tlo", function ()
    --                 builtin.lsp_document_symbols({
    --                     layout_config = { width = 0.95, height = 0.95 },
    --                 })
    --             end, "[L]SP [D]ocument Symbols", event.buf)
    --
    --             mapb("<leader>tlw", function ()
    --                 builtin.lsp_dynamic_workspace_symbols({
    --                     layout_strategy = "vertical",
    --                     layout_config = { width = 0.95, height = 0.95 },
    --                 })
    --             end, "[L]SP [W]orkspace Symbols", event.buf)
    --         end,
    --     })
end)
