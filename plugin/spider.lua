Angju.later(function ()
	vim.pack.add { 'https://github.com/chrisgrieser/nvim-spider' }

	local spider = require 'spider'
	spider.setup {}

	local keymaps = {
		{
			keys = 'e',
			func = function ()
				spider.motion 'e'
			end,
			desc = 'Spider [e]',
			mode = { 'n', 'x', 'o' },
		},
		{
			keys = 'w',
			func = function ()
				spider.motion 'w'
			end,
			desc = 'Spider [w]',
			mode = { 'n', 'x', 'o' },
		},
		{
			keys = 'b',
			func = function ()
				spider.motion 'b'
			end,
			desc = 'Spider [b]',
			mode = { 'n', 'x', 'o' },
		},
	}

	Angju.set_table_keymap(keymaps)
end)
