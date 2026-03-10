---@param servers_config table<string, vim.lsp.Config>
---@return string[]
local function enabled_servers (servers_config)
    local enabled = {}

    for server, config in pairs(servers_config) do
        vim.lsp.config[server] = config
        if server ~= '*' then table.insert(enabled, server) end
    end

    return enabled
end

-- ===========================================================================
-- Language Settings
-- ===========================================================================

-- Typescript and Javascript  (denols, ts_ls)
-- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md
local typescript_settings = {
    ['implicitProjectCOnfiguration.target'] = 'es2024',
    inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
    },
    ['implementationsCodeLens.enable'] = true,
    ['referencesCodeLens.enable'] = true,
    ['referencesCodeLens.showOnAllFunctions'] = true,
}

-- ===========================================================================
-- LSP Config
-- ===========================================================================

---@type table<string, vim.lsp.Config>
local servers = {
    ['*'] = {},
    lua_ls = {
        on_init = function (client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                    path ~= vim.fn.stdpath 'config'
                    and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', {}, client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT',
                    path = { 'lua/?.lua', 'lua/?/init.lua' },
                },
                workspace = {
                    checkThirdParty = 'Disable',
                    library = {
                        vim.env.VIMRUNTIME,
                        '${3rd}/luv/library',
                    },
                },
            })
        end,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'MiniDeps', 'MiniDiff' },
                    disable = { 'missing-fields' },
                },
            },
        },
    },
    ts_ls = {
        settings = {
            typescript = typescript_settings,
            javascript = typescript_settings,
        },
    },
    denols = {
        settings = {
            typescript = typescript_settings,
            javascript = typescript_settings,
        },
    },
    biome = {},
    taplo = {},
}

vim.lsp.enable(enabled_servers(servers))
