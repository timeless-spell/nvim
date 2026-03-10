-- ===========================================================================
-- Neovim config.
-- ===========================================================================

-- nvim-mini: Plugin manager. ================================================

local path_package = vim.fn.stdpath 'data' .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.uv.fs_stat(mini_path) then
	vim.cmd 'echo "Installing `mini.nvim`" | redraw'
	local clone_cmd = {
		'git',
		'clone',
		'--filter=blob:none',
		-- Uncomment next line to use 'stable' branch
		-- '--branch', 'stable',
		'https://github.com/nvim-mini/mini.nvim',
		mini_path,
	}
	vim.system(clone_cmd)
	vim.cmd 'packadd mini.nvim | helptags ALL'
	vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

require('mini.deps').setup { path = { package = path_package } }

-- Custom globals. ===========================================================

local Angju = {}

_G.Angju = Angju

---@class angju.Keymap: vim.keymap.set.Opts
---@field mode? string|string[]
---@field func string|function
---@field keys string

---@param keys string
---@param func string|function
---@param desc? string
---@param mode? string|string[]
function Angju.set_keymap (keys, func, desc, mode)
	vim.keymap.set(mode or 'n', keys, func, { desc = desc })
end

---@param keymap_table { mode:string|string[], keys:string, buf:number|boolean|nil }
function Angju.del_keymap (keymap_table)
	for _, opts in ipairs(keymap_table) do
		vim.keymap.del(opts.mode, opts.keys, { buffer = opts.buf })
	end
end

---@param keymap_table angju.Keymap[]
function Angju.multi_set_keymap (keymap_table)
	for _, opts in ipairs(keymap_table) do
		vim.keymap.set(opts.mode or 'n', opts.keys, opts.func, {
			desc = opts.desc,
			buffer = opts.buffer,
			callback = opts.callback,
			silent = opts.silent,
			nowait = opts.nowait,
			expr = opts.expr,
			noremap = opts.noremap,
		})
	end
end

-- Setup ===========================================================

---@param location string
---@param modules string[]
local function req (location, modules)
	for _, value in ipairs(modules) do
		pcall(require, location .. '.' .. value)
	end
end

local setup = {
	angju = { 'options', 'keymaps', 'diagnostics', 'autocmds', 'lsp' },
	plugins = {
		-- https://github.com/folke/tokyonight.nvim
		'tokyonight',

		-- https://github.com/scottmckendry/cyberdream.nvim
		'cyberdream',

		-- Local project
		'grim',

		-- https://github.com/nvim-tree/nvim-web-devicons
		'devicons',

		-- https://github.com/neovim/nvim-lspconfig
		-- https://github.com/nvim-lua/plenary.nvim
		'lib',

		-- https://github.com/nvim-mini/mini.nvim
		'mini',

		-- https://github.com/nvim-treesitter/nvim-treesitter
		-- https://github.com/nvim-treesitter/nvim-treesitter-context
		'treesitter',

		-- https://cmp.saghen.dev/
		'blink',

		-- https://github.com/stevearc/conform.nvim
		'conform',

		-- https://github.com/chrisgrieser/nvim-lsp-endhints
		'endhints',

		-- https://github.com/j-hui/fidget.nvim
		'fidget',

		-- https://github.com/ibhagwan/fzf-lua
		'fzf', -- https://github.com/ibhagwan/fzf-lua

		-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
		-- https://github.com/nvim-telescope/telescope.nvim
		-- https://github.com/nvim-telescope/telescope-file-browser.nvim
		-- https://github.com/nvim-telescope/telescope-ui-select.nvim
		-- https://github.com/jvgrootveld/telescope-zoxide
		'telescope',

		-- https://github.com/OXY2DEV/markview.nvim
		-- https://github.com/OXY2DEV/helpview.nvim
		'view',

		-- https://github.com/NeogitOrg/neogit
		'neogit',

		-- https://github.com/mfussenegger/nvim-lint
		'lint',

		-- https://github.com/folke/todo-comments.nvim
		'todo-comments',

		-- https://github.com/gbprod/yanky.nvim
		'yanky',

		-- https://github.com/gbprod/substitute.nvim
		'substitute',

		-- https://github.com/folke/flash.nvim
		'flash',

		-- https://github.com/brenoprata10/nvim-highlight-colors
		'highlight-colors',

		-- https://github.com/shellRaining/hlchunk.nvim
		'hlchunk',

		-- https://github.com/chrisgrieser/nvim-spider
		'spider',

		-- https://github.com/kdheepak/lazygit.nvim
		'lazygit',

		-- https://github.com/NMAC427/guess-indent.nvim
		'guess-indent',

		-- https://github.com/windwp/nvim-ts-autotag
		'autotag',

		-- https://github.com/stevearc/quicker.nvim
		'quicker',

		-- https://github.com/kevinhwang91/nvim-bqf
		'bqf',

		-- https://github.com/stevearc/resession.nvim
		'resession',

		-- https://github.com/mfussenegger/nvim-jdtls
		'jdtls',

		-- https://github.com/mfussenegger/nvim-dap
		-- https://github.com/rcarriga/nvim-dap-ui
		'dap',

		-- Local project
		'cubes',
	},
}

req('angju', setup.angju)
req('angju.plugins', setup.plugins)
