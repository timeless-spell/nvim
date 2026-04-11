-- ===========================================================================
-- Neovim config.
-- ===========================================================================

-- Options. ==================================================================

local g = vim.g
g.mapleader = ' '
g.maplocalleader = ' '

g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0

local o = vim.o
local opt = vim.opt

o.mouse = 'a'
o.mousescroll = 'ver:25,hor:6'
o.undofile = true
o.shada = "'100,<50,s10,:1000,/100,@100,h"
o.updatetime = 250

o.breakindent = true
o.cursorline = true
o.number = true
o.relativenumber = true
o.ruler = false
o.signcolumn = 'yes'
o.splitbelow = true
o.splitright = true
o.inccommand = 'split'
o.backup = false
o.showmode = false
o.scrolloff = 5
o.wrap = false
o.termguicolors = true

o.list = true
opt.listchars = { eol = '󱞥', tab = '| ' }

o.autoread = true
o.autoindent = true
o.expandtab = true
o.ignorecase = true
o.incsearch = true
o.infercase = true
o.shiftwidth = 2
o.smartcase = true
o.smartindent = true
o.spelloptions = 'camel'
o.tabstop = 2
o.virtualedit = 'block'

-- Custom globals. ===========================================================

local Angju = {}

_G.Angju = Angju

---@param keys string
---@param func string|function
---@param desc? string
---@param mode? string|string[]
function Angju.set_keymap (keys, func, desc, mode)
	vim.keymap.set(mode or 'n', keys, func, { desc = desc or nil })
end

---@param keys string
---@param buf? number
---@param mode? string|string[]
function Angju.del_keymap (keys, buf, mode)
	vim.keymap.del(mode or 'n', keys, { buffer = buf })
end

---@class angju.keymap.Set : vim.keymap.set.Opts
---@field keys string
---@field func string|function
---@field mode? string|string[]

---@param keymap_table angju.keymap.Set[]
function Angju.set_table_keymap (keymap_table)
	for _, opts in ipairs(keymap_table) do
		vim.keymap.set(opts.mode or 'n', opts.keys, opts.func, {
			buf = opts.buf,
			desc = opts.desc,
			callback = opts.callback,
			silent = opts.silent,
			nowait = opts.nowait,
			expr = opts.expr,
			noremap = opts.noremap,
		})
	end
end

---@class angju.keymap.Del
---@field keys string
---@field buffer? number
---@field mode? string|string[]

---@param keymap_table angju.keymap.Del[]
function Angju.del_table_keymap (keymap_table)
	for _, opts in ipairs(keymap_table) do
		vim.keymap.del(opts.mode or 'n', opts.keys, { buf = opts.buffer })
	end
end

-- mini.nvim =================================================================

vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

local misc = require 'mini.misc'

---@param f function
function Angju.now (f)
	misc.safely('now', f)
end

---@param f function
function Angju.later (f)
	misc.safely('later', f)
end

Angju.now_if_args = vim.fn.argc(-1) > 0 and Angju.now or Angju.later

---@param ev vim.api.keyset.events
---@param f function
function Angju.on_event (ev, f)
	misc.safely('event:' .. ev, f)
end

---@param ft string
---@param f function
function Angju.on_filetype (ft, f)
	misc.safely('filetype:' .. ft, f)
end

local gr = vim.api.nvim_create_augroup('custom-config', {})

---@param event vim.api.keyset.events
---@param pattern string|string[]
---@param callback function
---@param desc string
function Angju.new_autocmd (event, pattern, callback, desc)
	local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
	vim.api.nvim_create_autocmd(event, opts)
end

---@param plugin_name string
---@param kinds table
---@param callback function
---@param desc string
function Angju.on_packchanged (plugin_name, kinds, callback, desc)
	local f = function (ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
		if not ev.data.active then vim.cmd.packadd(plugin_name) end
		callback(ev.data)
	end
	Angju.new_autocmd('PackChanged', '*', f, desc)
end

-- Autocmds ========================================================

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function ()
		vim.hl.on_yank()
	end,
})

-- Diagnostics =====================================================

Angju.later(function ()
	local diagnostics_visible = true

	local function toggleDiagnostics ()
		if diagnostics_visible then
			vim.diagnostic.hide()
			diagnostics_visible = false
		else
			vim.diagnostic.show()
			diagnostics_visible = true
		end
	end

	---@type vim.diagnostic.Opts
	local diagnostic_setup = {
		config = {
			severity_sort = true,
			float = { header = ' Diagnostics ', border = 'single', source = 'if_many' },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = '󰅚 ',
					[vim.diagnostic.severity.WARN] = '󰀪 ',
					[vim.diagnostic.severity.INFO] = '󰋽 ',
					[vim.diagnostic.severity.HINT] = '󰌶 ',
				},
			} or {},
			virtual_text = {
				source = 'if_many',
				spacing = 2,
				format = function (diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		},
	}

	---@type angju.keymap.Set[]
	local diagnostic_keymaps = {
		{ keys = '<leader>dl', func = vim.diagnostic.setloclist, desc = 'Open diagnostic Location list' },
		{ keys = '<leader>dq', func = vim.diagnostic.setqflist, desc = 'Open diagnostic Quickfix list' },
		{ keys = '<leader>df', func = vim.diagnostic.open_float, desc = 'Open diagnostic Float' },
		{ keys = '<leader>dt', func = toggleDiagnostics, desc = 'Hide/Show diagnostic' },
	}

	vim.diagnostic.config(diagnostic_setup.config)
	Angju.set_table_keymap(diagnostic_keymaps)
end)

-- Keymaps =========================================================

---@type angju.keymap.Set[]
local keymaps = {
	-- Source files
	{ keys = '<Leader><Space>sf', func = '<CMD>source %<CR>', desc = 'Source file/buffer' },
	{ keys = '<Leader><Space>sl', func = '<CMD>.lua<CR>', desc = 'Source line' },
	{
		keys = '<Leader><Space>sc',
		func = ":'<,'>lua<CR>",
		desc = 'Source selected Lua code',
		mode = 'x',
	},

	-- Inspect
	{ keys = '<Leader><Space>i', func = '<CMD>Inspect<CR>', desc = 'Inspect' },

	-- Navigate buffers
	{ keys = '<A-a>', func = '<CMD>bprevious<CR>', desc = 'Previous Buffer' },
	{ keys = '<A-d>', func = '<CMD>bnext<CR>', desc = 'Next Buffer' },

	-- Delete current buffer
	-- { keys = '<a-x>', func = '<cmd>bdelete<cr>', desc = 'Delete buffer' },

	-- Navigate splits
	{ keys = '<C-h>', func = '<C-w><C-h>', desc = 'Move focus to the left window ' },
	{ keys = '<C-l>', func = '<C-w><C-l>', desc = 'Move focus to the right window ' },
	{ keys = '<C-j>', func = '<C-w><C-j>', desc = 'Move focus to the lower window ' },
	{ keys = '<C-k>', func = '<C-w><C-k>', desc = 'Move focus to the upper window ' },

	-- Clear highlight on search
	{ keys = '<esc>', func = '<CMD>nohlsearch<CR>', desc = 'Clear highlight' },

	-- Modify Split Size
	{ keys = '<C-up>', func = '<CMD>resize -2<CR><CR>', desc = 'Resize split Up' },
	{ keys = '<C-down>', func = '<CMD>resize +2<CR><CR>', desc = 'Resize split Down' },
	{ keys = '<C-left>', func = '<CMD>vertical resize -2<CR>', desc = 'Resize split Left' },
	{ keys = '<C-right>', func = '<CMD>vertical resize +2<CR>', desc = 'Resize split Right' },

	-- Select color scheme
	-- Ron
	{
		keys = '<Leader><Space>cr',
		func = function ()
			vim.cmd 'colorscheme ron'
			vim.cmd 'hi NonText guibg=none'
		end,
		desc = 'Colorscheme: Ron',
	},
	-- Sorbet
	{
		keys = '<Leader><Space>cs',
		func = '<CMD>colorscheme sorbet<CR>',
		desc = 'Colorscheme: Sorbet',
	},
}

local unmap = {
	{ mode = { 'n', 'v' }, keys = 'gra' },
	{ mode = 'n', keys = 'grr' },
	{ mode = 'n', keys = 'grt' },
	{ mode = 'n', keys = 'gri' },
	{ mode = 'n', keys = 'grn' },
}

Angju.set_table_keymap(keymaps)
Angju.del_table_keymap(unmap)

-- User Commands =========================================================

-- local c_cmd = vim.api.nvim_create_user_command
