--- @class ang.Keymap: vim.api.keyset.keymap
--- @field keys string
--- @field func function | string
--- @field mode? string | string[]

--- @type ang.Keymap[]
local keymaps = {
	{ keys = '<M-d>', func = '<CMD>bnext<CR>', desc = 'Next buffer -->' },
	{ keys = '<M-a>', func = '<CMD>bprevious<CR>', desc = 'Prev buffer <--' },

	{ keys = '<Esc>', func = '<CMD>nohlsearch<CR>', desc = 'Delete buffer <--' },

	{ keys = '<C-h>', func = '<C-w><C-h>', desc = 'Move focus left' },
	{ keys = '<C-j>', func = '<C-w><C-j>', desc = 'Move focus down' },
	{ keys = '<C-k>', func = '<C-w><C-k>', desc = 'Move focus up' },
	{ keys = '<C-l>', func = '<C-w><C-l>', desc = 'Move focus right' },

	{ keys = 'X', func = 'd0', desc = 'Delete all characters before cursor' },

	-- Source (:source) files
	{ keys = '<Leader><Space>sf', func = '<CMD>source %<CR>', desc = 'Source file/buffer' },
	{ keys = '<Leader><Space>sl', func = '<CMD>.lua<CR>', desc = 'Source line' },
	{ keys = '<Leader><Space>sc', func = ':"<,">lua<CR>', desc = 'Source selected Lua code', mode = 'x' },

	-- Inspect (:Inspect)
	{ keys = '<Leader><Space>i', func = '<CMD>Inspect<CR>', desc = 'Inspect' },

	-- Modify Split Size
	{ keys = '<C-up>', func = '<CMD>resize -2<CR><CR>', desc = 'Resize split Up' },
	{ keys = '<C-down>', func = '<CMD>resize +2<CR><CR>', desc = 'Resize split Down' },
	{ keys = '<C-left>', func = '<CMD>vertical resize -2<CR>', desc = 'Resize split Left' },
	{ keys = '<C-right>', func = '<CMD>vertical resize +2<CR>', desc = 'Resize split Right' },
}

Ang.tbl_map (keymaps)
