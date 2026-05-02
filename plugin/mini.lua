local now, ltr = Angju.now, Angju.later

--
-- MiniNotify:
--
ltr(
	function ()
		require('mini.notify').setup {
			window = {
				config = {
					border = 'solid',
				},
				winblend = 20,
			},
			lsp_progress = {
				enable = false,
			},
		}
	end
)

--
-- MiniFiles:
--
ltr(function ()
	require('mini.files').setup {
		options = { use_as_default_explorer = false },
	}

	vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

	Angju.set_keymap('<leader>mf', '<cmd>lua MiniFiles.open()<cr>', 'Open MiniFiles')
end)

--
-- MiniPairs:
--
ltr(function () require('mini.pairs').setup() end)

--
-- MiniExtra
--
ltr(function () require('mini.extra').setup() end)

--
-- MiniPick:
--
ltr(function ()
	require('mini.pick').setup()
	Angju.set_keymap('<leader>msf', '<CMD>lua MiniPick.builtin.files()<CR>', 'Files [MiniPick]')
	Angju.set_keymap('<leader>msb', '<CMD>lua MiniPick.builtin.buffers()<CR>', 'Buffers [MiniPick]')
end)

--
-- MiniAi:
--
ltr(function ()
	local spec_treesitter = require('mini.ai').gen_spec.treesitter
	local gen_ai_spec = require('mini.extra').gen_ai_spec
	require('mini.ai').setup {
		custom_textobjects = {
			F = spec_treesitter { a = '@function.outer', i = '@function.inner' },
			o = spec_treesitter {
				a = { '@conditional.outer', '@loop.outer' },
				i = { '@conditional.inner', '@loop.inner' },
			},
			C = spec_treesitter { a = '@comment.outer', i = '@comment.inner' },
			B = gen_ai_spec.buffer(),
			D = gen_ai_spec.diagnostic(),
			I = gen_ai_spec.indent(),
			L = gen_ai_spec.line(),
			N = gen_ai_spec.number(),
		},
	}
end)

--
-- MiniComment:
--
ltr(function () require('mini.comment').setup() end)

--
-- MiniCursorword:
--
ltr(function () require('mini.cursorword').setup() end)

--
-- MiniMove:
--
ltr(function () require('mini.move').setup() end)

--
-- MiniSurround:
--
ltr(
	function ()
		require('mini.surround').setup {
			mappings = {
				add = 'msa',
				delete = 'msd',
				find = 'msf',
				find_left = 'msF',
				highlight = 'msh',
				replace = 'msr',
				update_n_lines = 'msn',

				suffix_last = 'l',
				suffix_next = 'n',
			},
		}
	end
)

--
-- MiniGit
--
ltr(function () require('mini.git').setup() end)

--
-- MiniBufremove
--
ltr(function ()
	local bufremove = require 'mini.bufremove'
	bufremove.setup()
	Angju.set_keymap('<a-x>', function () bufremove.delete() end, 'Delete buffer')
end)

--
-- MiniClue
--
ltr(function ()
	local miniclue = require 'mini.clue'
	miniclue.setup {
		triggers = {
			{ mode = { 'n', 'x' }, keys = '<Leader>' },
			{ mode = { 'n', 'x' }, keys = 'g' },
			{ mode = { 'n', 'x' }, keys = '"' },
			{ mode = { 'i', 'c' }, keys = '<C-R>' },
			{ mode = 'n', keys = '[' },
			{ mode = 'n', keys = ']' },
			{ mode = { 'n', 'x' }, keys = '\\' },
			{ mode = { 'n', 'x', 'o' }, keys = 's' },
		},
		clues = {
			{ mode = 'n', keys = '<Leader><Space>', desc = ' +User' },
			{ mode = 'n', keys = '<Leader><Space>c', desc = ' +User/Colorscheme' },
			{ mode = 'n', keys = '<Leader><Space>s', desc = ' +User/Source' },
			{ mode = 'n', keys = '<Leader>f', desc = ' +Fzf' },
			{ mode = 'n', keys = '<Leader>fl', desc = ' +Fzf/LSP' },
			{ mode = 'n', keys = '<Leader>s', desc = ' +Telescope' },
			{ mode = 'n', keys = '<Leader>m', desc = '󰮋 +Mini' },
			{ mode = 'n', keys = '<Leader>ms', desc = '󰮋 +Mini/Picker' },
			{ mode = { 'n', 'x' }, keys = '<Leader>l', desc = ' +LSP' },
			{ mode = 'n', keys = '<Leader>lg', desc = ' +LSP/Go to' },
			{ mode = 'n', keys = '<Leader>d', desc = ' +Diagnostics' },
			{ mode = 'n', keys = '<Leader>g', desc = ' +Git' },
			{ mode = 'n', keys = '<Leader>r', desc = ' +Resession' },
			{ mode = 'n', keys = '<Leader>x', desc = ' +Quicker' },
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.square_brackets(),
		},
	}
end)

ltr(function ()
	local hipatterns = require 'mini.hipatterns'

	hipatterns.setup {
		highlighters = {
			todo = { pattern = '%f[%w]()TO%p-DO()%f[%W]', group = 'MiniHipatternsTodo' },
			hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
			fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
			note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
		},
	}
end)

ltr(function ()
	---@type angju.Keymap[]
	local mini_keymaps = {
		{
			keys = '<Leader><Space>ca',
			func = '<CMD>colorscheme miniautumn<CR>',
			desc = 'Colorscheme: MiniAutumn',
		},
		{
			keys = '<Leader><Space>cu',
			func = '<CMD>colorscheme minisummer<CR>',
			desc = 'Colorscheme: MiniSummer',
		},
	}
	Angju.set_table_keymap(mini_keymaps)
end)
