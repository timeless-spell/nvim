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
    denols = {
        root_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" }),
        workspace_required = true,
        settings = {
            typescript = {},
        },
    },
    biome = {
        workspace_required = true,
        root_dir = vim.fs.root(0, { "biome.json" }),
    },
}

for server, config in pairs(servers) do
    vim.lsp.config[server] = config
end

vim.lsp.enable({ "lua_ls", "biome", "denols" })
