MiniDeps.later(function ()
	MiniDeps.add {
		source = 'https://codeberg.org/andyg/leap.nvim',
	}

	require('leap').opts.safe_labels = ''

	local function ft (key_specific_args)
		require('leap').leap(vim.tbl_deep_extend('keep', key_specific_args, {
			inputlen = 1,
			inclusive = true,
			opts = {
				-- Force autojump.
				labels = '',
				-- Match the modes where you don't need labels (`:h mode()`).
				safe_labels = vim.fn.mode(1):match 'o' and '' or nil,
			},
		}))
	end

	-- A helper function making it easier to set "clever-f" behavior
	-- (using f/F or t/T instead of ;/, - see the plugin clever-f.vim).
	local clever = require('leap.user').with_traversal_keys
	local clever_f, clever_t = clever('f', 'F'), clever('t', 'T')

	---@type angju.Keymap[]
	local keymaps = {
		{
			mode = { 'n', 'x', 'o' },
			keys = 'f',
			func = function ()
				ft { opts = clever_f }
			end,
			desc = 'f [Leap]',
		},
		{
			mode = { 'n', 'x', 'o' },
			keys = 'F',
			func = function ()
				ft { backward = true, opts = clever_f }
			end,
			desc = 'F [Leap]',
		},
		{
			mode = { 'n', 'x', 'o' },
			keys = 't',
			func = function ()
				ft { offset = -1, opts = clever_t }
			end,
			desc = 't [Leap]',
		},
		{
			mode = { 'n', 'x', 'o' },
			keys = 'T',
			func = function ()
				ft { backward = true, offset = 1, opts = clever_t }
			end,
			desc = 'T [Leap]',
		},
		{ mode = { 'n', 'x', 'o' }, keys = '\\s', func = '<Plug>(leap-forward)', desc = 'Forward [Leap]' },
		{ mode = 'n', keys = '\\S', func = '<Plug>(leap-backward)', desc = 'Backward [Leap]' },
		{ mode = 'n', keys = '\\w', func = '<Plug>(leap-from-window)', desc = 'Window [Leap]' },
		{ mode = 'n', keys = '\\W', func = '<Plug>(leap-anywhere)', desc = 'Everywhere [Leap]' },
		{
			mode = { 'x', 'o' },
			keys = '\\t',
			func = function ()
				require('leap.treesitter').select {
					opts = require('leap.user').with_traversal_keys('R', 'r'),
				}
			end,
			desc = 'Treesitter [Leap]',
		},
		{
			mode = { 'n', 'x', 'o' },
			keys = '\\r',
			func = function ()
				require('leap.remote').action()
			end,
			desc = 'Remote [Leap]',
		},
	}
	Angju.multi_set_keymap(keymaps)
end)
