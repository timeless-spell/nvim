-- Custom globals

local Angju = {}

_G.Angju = Angju

---@class angju.Keymap: vim.keymap.set.Opts
---@field mode? string|string[]
---@field func string|function
---@field keys string

---@param opts angju.Keymap
function Angju.map (opts)
    opts.mode = opts.mode or "n"
    opts.buffer = opts.buffer or nil
    opts.desc = opts.desc or nil
    vim.keymap.set(opts.mode, opts.keys, opts.func, { desc = opts.desc, buffer = opts.buffer })
end

---@param opts angju.Keymap[]
function Angju.multi_map (opts)
    for _, opt in ipairs(opts) do
        vim.keymap.set(opt.mode or "n", opt.keys, opt.func, {
            desc = opt.desc,
            buffer = opt.buffer,
            callback = opt.callback,
            silent = opt.silent,
            nowait = opt.nowait,
            expr = opt.expr,
            noremap = opt.noremap,
        })
    end
end

---@param dir string
---@param tbl string[]
function Angju.req (dir, tbl)
    for _, value in ipairs(tbl) do
        pcall(require, dir .. "." .. value)
    end
end

-- [ nvim-mini ]
local path_package = vim.fn.stdpath("data") .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        -- Uncomment next line to use 'stable' branch
        -- '--branch', 'stable',
        "https://github.com/nvim-mini/mini.nvim",
        mini_path,
    }
    vim.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require("mini.deps").setup({ path = { package = path_package } })

-- [ Custom config ]

local setup = {
    config = {
        "options",
        "keymaps",
        "lsp",
        "diagnostics",
    },
    plugins = {
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
    },
    autocmds = {
        "highlight",
        "lsp",
    },
}

Angju.req("config", setup.config)
Angju.req("autocmds", setup.autocmds)
Angju.req("plugins", setup.plugins)
