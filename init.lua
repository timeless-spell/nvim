-- [ nvim-mini ]
local path_package = vim.fn.stdpath ("data") .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.nvim"
if not vim.uv.fs_stat (mini_path) then
    vim.cmd ('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        -- Uncomment next line to use 'stable' branch
        -- '--branch', 'stable',
        "https://github.com/nvim-mini/mini.nvim",
        mini_path,
    }
    vim.system (clone_cmd)
    vim.cmd ("packadd mini.nvim | helptags ALL")
    vim.cmd ('echo "Installed `mini.nvim`" | redraw')
end

require ("mini.deps").setup ({ path = { package = path_package } })

--
-- TODO: Automatize the requirement of modules
--

-- [ Config ]
local globals = require ("config.globals")
local req = Angju.dynamic_require

--- @type string[]
local config = {
    "options",
    "keymaps",
    "lsp",
    "diagnostics",
}

req ("config", config)

-- [ Plugins ]

--- @type string[]
local plugins = {
    "grim",
    "lib",
    "mini",
    "notify",
    "fidget",
    "treesitter",
    "blink",
    "conform",
    "endhints",
    "fzf",
    "telescope",
    "view",
    "neogit",
    "lint",
    "todo-comments",
    "yanky",
    "substitute",
    "flash",
    "which-key",
    "fff",
    "highlight-colors",
    "hlchunk",
    "spider",
    "lazygit",
    "guess-indent",
    "autotag",
    "quicker",
    "bqf",
    "resession",
    "cubes",
    "lspkind",
}

req ("plugins", plugins)

-- [ Autocommands ]

--- @type string[]
local autocmds = {
    "highlight",
    "lsp",
}

req ("autocmds", autocmds)
