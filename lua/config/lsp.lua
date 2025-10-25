local capabilities = {}

local ok, blink = pcall (require, "blink.cmp")

if ok then
    capabilities = blink.get_lsp_capabilities (capabilities)
end

vim.lsp.config ("*", {
    capabilities = capabilities,
})
--
vim.lsp.config["lua_ls"] = {
    --   on_init = function (client)
    --     if client.workspace_folders then
    --       local path = client.workspace_folders[1].name
    --       if path ~= vim.fn.stdpath ('config') and (vim.uv.fs_stat (path .. '/.luarc.json') or vim.uv.fs_stat (path .. '/.luarc.jsonc')) then
    --         return
    --       end
    --     end
    --
    --     client.config.settings.Lua = vim.tbl_deep_extend ('force', client.config.settings.Lua, {
    --       runtime = {
    --         version = 'LuaJIT',
    --       },
    --       workspace = {
    --         checkThirdParty = false,
    --         library = {
    --           vim.env.VIMRUNTIME,
    --           '${3rd}/luv/library',
    --         },
    --       },
    --     })
    --   end,
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
                enable = true,
            },
        },
    },
}

vim.lsp.enable ({ "lua_ls", "jsonls" })
