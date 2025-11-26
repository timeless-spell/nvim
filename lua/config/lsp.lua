local ts_and_js_settings = {
    typescript = {
        inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        },
    },
    javascript = {
        inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        },
    },
}

local capabilities = {}

local ok, blink = pcall(require, "blink.cmp")

if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
end

---@type table<string, vim.lsp.Config>
local servers = {
    ["*"] = {
        capabilities = capabilities,
    },
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippeet = "Replace",
                },
                diagnostics = {
                    globals = { "MiniDeps", "MiniDiff" },
                    disable = {
                        "missing-fields",
                    },
                },
                hint = {
                    enable = false,
                },
            },
        },
    },
    ts_ls = {
        root_dir = function (bufnr, on_dir)
            local root_markers = { "tsconfig.json", "package.json", "package-lock.json", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
            local project_root = vim.fs.root(bufnr, root_markers)
            on_dir(project_root)
        end,
        workspace_required = true,
        settings = ts_and_js_settings,
    },
    denols = {
        -- root_dir = function (bufnr, on_dir)
        --     local root_markers = { "deno.json", "deno.jsonc" }
        --     local project_root = vim.fs.root(bufnr, root_markers)
        --     on_dir(project_root)
        -- end,
        root_markers = { "deno.json", "deno.jsonc" },
        workspace_required = true,
        settings = ts_and_js_settings,
    },
    biome = {
        workspace_required = true,
    },
    taplo = {},
}

local enabled = {}

for server, config in pairs(servers) do
    vim.lsp.config[server] = config
    if server ~= "*" then
        table.insert(enabled, server)
    end
end

vim.lsp.enable(enabled)
