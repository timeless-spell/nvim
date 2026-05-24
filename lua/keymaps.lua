--- @class ang.Keymap: vim.api.keyset.keymap
--- @field keys string
--- @field func function | string
--- @field mode? string | string[]

--- @type ang.Keymap[]
local keymaps = {
	-- Navigate buffers
	{ keys = '<M-d>', func = '<CMD>bnext<CR>', desc = 'Next buffer ' },
	{ keys = '<M-a>', func = '<CMD>bprevious<CR>', desc = 'Prev buffer ' },

	{ keys = '<Esc>', func = '<CMD>nohlsearch<CR>', desc = 'Clear highlight ❌' },

	{ keys = 'X', func = 'd0', desc = 'Delete all characters before cursor' },

	-- Inspect (:Inspect)
	{ keys = '<Leader><Space>i', func = '<CMD>Inspect<CR>', desc = 'Inspect' },

	-- Source (:source) files
	{ keys = '<Leader><Space>sf', func = '<CMD>source %<CR>', desc = 'Source file/buffer' },
	{ keys = '<Leader><Space>sl', func = '<CMD>.lua<CR>', desc = 'Source line' },
	{ keys = '<Leader><Space>sc', func = ':"<,">lua<CR>', desc = 'Source selected Lua code', mode = 'x' },

	-- Navigate splits
	{ keys = '<C-h>', func = '<C-w><C-h>', desc = 'Move focus left ' },
	{ keys = '<C-j>', func = '<C-w><C-j>', desc = 'Move focus down ' },
	{ keys = '<C-k>', func = '<C-w><C-k>', desc = 'Move focus up ' },
	{ keys = '<C-l>', func = '<C-w><C-l>', desc = 'Move focus right ' },

	-- Modify Split Size
	{ keys = '<C-up>', func = '<CMD>resize -2<CR><CR>', desc = 'Resize split Up' },
	{ keys = '<C-down>', func = '<CMD>resize +2<CR><CR>', desc = 'Resize split Down' },
	{ keys = '<C-left>', func = '<CMD>vertical resize -2<CR>', desc = 'Resize split Left' },
	{ keys = '<C-right>', func = '<CMD>vertical resize +2<CR>', desc = 'Resize split Right' },

	-- Yank and put + (system) clipboard
	{ keys = '<Leader><Space>y', func = '"+y', desc = 'Yank to + clipboard' },
	{ keys = '<Leader><Space>p', func = '"+p', desc = 'Put from + clipboard' },
}

Ang.tbl_map (keymaps)
