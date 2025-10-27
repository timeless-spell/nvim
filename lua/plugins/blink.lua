MiniDeps.later(function ()
    MiniDeps.add({
        source = "saghen/blink.cmp",
        depends = {
            "MahanRahmati/blink-nerdfont.nvim",
            "moyiz/blink-emoji.nvim",
            "brenoprata10/nvim-highlight-colors",
            "folke/lazydev.nvim",
        },
        checkout = "v1.7.0",
    })

    ---@type blink.cmp.Config
    local blink_config = {
        cmdline = {
            enabled = true,
        },
        completion = {
            list = {
                selection = {
                    preselect = function (ctx)
                        return ctx.mode ~= "cmdline"
                    end,
                },
            },
            menu = {
                max_height = 30,
                border = "solid",
                winblend = 10,
                scrollbar = false,
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind", gap = 1 },
                        { "source_name", gap = 1 },
                    },
                    -- NOTE: nvim-web-devicons and nvim-highlight-colors support:
                    components = {
                        kind_icon = {
                            text = function (ctx)
                                local icon = ctx.kind_icon
                                if ctx.item.source_name == "LSP" then
                                    local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                                    if color_item and color_item.abbr ~= "" then
                                        icon = color_item.abbr
                                    end
                                end
                                return icon .. ctx.icon_gap
                            end,
                            highlight = function (ctx)
                                local highlight = "BlinkCmpKind" .. ctx.kind
                                if ctx.item.source_name == "LSP" then
                                    local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                                    if color_item and color_item.abbr_hl_group then
                                        highlight = color_item.abbr_hl_group
                                    end
                                end
                                return highlight
                            end,
                        },
                    },

                    -- NOTE: mini.icons and nvim-highlight-colors support:
                    -- components = {
                    --     kind_icon = {
                    --         text = function (ctx)
                    --             local kind_icon, _, _ = require ('mini.icons').get ('lsp', ctx.kind)
                    --             if ctx.item.source_name == 'LSP' then
                    --                 local color_item = require ('nvim-highlight-colors').format (ctx.item.documentation, { kind = kind_icon })
                    --                 if color_item and color_item.abbr ~= '' then
                    --                     kind_icon = color_item.abbr
                    --                 end
                    --             end
                    --             return kind_icon .. ctx.icon_gap
                    --         end,
                    --         highlight = function (ctx)
                    --             local _, hl, _ = require ('mini.icons').get ('lsp', ctx.kind)
                    --             if ctx.item.source_name == 'LSP' then
                    --                 local color_item = require ('nvim-highlight-colors').format (ctx.item.documentation, { kind = ctx.kind })
                    --                 if color_item and color_item.abbr_hl_group then
                    --                     hl = color_item.abbr_hl_group
                    --                 end
                    --             end
                    --             return hl
                    --         end,
                    --     },
                    --     kind = {
                    --         highlight = function (ctx)
                    --             local _, hl, _ = require ('mini.icons').get ('lsp', ctx.kind)
                    --             return hl
                    --         end,
                    --     },
                    -- },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = { border = "solid" },
            },
        },
        keymap = { preset = "default" },
        appearance = {
            nerd_font_variant = "mono",
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "nerdfont", "emoji", "lazydev" },
            providers = {
                cmdline = {
                    enabled = function ()
                        return vim.fn.getcmdline():sub(1, 1) ~= "!"
                    end,
                },
                nerdfont = {
                    module = "blink-nerdfont",
                    name = "Nerd Fonts",
                    score_offset = 0,
                    opts = { insert = true },
                    min_keyword_length = 3,
                },
                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                    score_offset = 0,
                    opts = { insert = true },
                },
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
    }

    require("blink.cmp").setup(blink_config)

    require("lazydev").setup({
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            "grim.nvim",
        },
    })
end)
