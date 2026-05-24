Ang.pack_add  'nvim-mini/mini.nvim'

-- ==============================
-- MiniIcons
-- ==============================
require ('mini.icons').setup ()

-- ==============================
-- MiniStatusline
-- ==============================
require ('mini.statusline').setup ()

-- ==============================
-- MiniFiles
-- ==============================
local files = require  'mini.files'
files.setup ()

Ang.map ('<Leader>mf', files.open, 'Open [MiniFiles]')

-- ==============================
-- MiniAi
-- ==============================
Ang.pack_add  'nvim-treesitter/nvim-treesitter-textobjects'

local spec_treesitter = require ('mini.ai').gen_spec.treesitter
local gen_ai_spec = require ('mini.extra').gen_ai_spec

require ('mini.ai').setup  {
	mappings = {
		around_next = 'aa',
		inside_next = 'ii',
	},
	custom_textobjects = {
		F = spec_treesitter  { a = '@function.outer', i = '@function.inner' },
		o = spec_treesitter  {
			a = { '@conditional.outer', '@loop.outer' },
			i = { '@conditional.inner', '@loop.inner' },
		},
		C = spec_treesitter  { a = '@comment.outer', i = '@comment.inner' },
		B = gen_ai_spec.buffer (),
		D = gen_ai_spec.diagnostic (),
		I = gen_ai_spec.indent (),
		L = gen_ai_spec.line (),
		N = gen_ai_spec.number (),
	},
}

-- ==============================
-- MiniSurround
-- ==============================
require ('mini.surround').setup ()

-- ==============================
-- MiniMove
-- ==============================
require ('mini.move').setup ()

-- ==============================
-- MiniBufremove
-- ==============================
local bufremove = require  'mini.bufremove'
bufremove.setup ()

Ang.map ('<M-x>', bufremove.delete, 'Delete buffer [MiniBufremove]')

-- ==============================
-- MiniHipatterns
-- ==============================
require ('mini.hipatterns').setup  {
	highlighters = {
		todo = { pattern = 'TODO:', group = 'MiniHipatternsTodo' },
		hack = { pattern = 'HACK:', group = 'MiniHipatternsHack' },
		fixme = { pattern = 'FIXME:', group = 'MiniHipatternsFixme' },
		note = { pattern = 'NOTE:', group = 'MiniHipatternsNote' },
	},
}

-- ==============================
-- MiniNotify
-- ==============================
require ('mini.notify').setup  {
	window = {
		config = { border = 'solid' },
		winblend = 20,
	},
	lsp_progress = { enable = true },
}

-- ==============================
-- MiniComment
-- ==============================
require ('mini.comment').setup ()

-- ==============================
-- MiniClue
-- ==============================
local clue = require  'mini.clue'
clue.setup  {
	window = {
		delay = 0,
		config = {
			width = 40,
		},
	},
	triggers = {
		-- Leader triggers
		{ mode = { 'n', 'x' }, keys = '<Leader>' },

		-- `[` and `]` keys
		{ mode = 'n', keys = '[' },
		{ mode = 'n', keys = ']' },

		-- Built-in completion
		{ mode = 'i', keys = '<C-x>' },

		-- `g` key
		{ mode = { 'n', 'x' }, keys = 'g' },

		-- Marks
		{ mode = { 'n', 'x' }, keys = "'" },
		{ mode = { 'n', 'x' }, keys = '`' },

		-- Registers
		{ mode = { 'n', 'x' }, keys = '"' },
		{ mode = { 'i', 'c' }, keys = '<C-r>' },

		-- Window commands
		{ mode = 'n', keys = '<C-w>' },

		-- `z` key
		{ mode = { 'n', 'x' }, keys = 'z' },
	},

	clues = {
		{ mode = { 'n', 'x' }, keys = '<Leader>s', desc = ' Telescope' },
		{ mode = { 'n' }, keys = '<Leader>r', desc = ' Resession' },
		{ mode = { 'n' }, keys = '<Leader>d', desc = ' Diagnostics' },
		-- Enhance this by adding descriptions for <Leader> mapping groups
		clue.gen_clues.square_brackets (),
		clue.gen_clues.builtin_completion (),
		clue.gen_clues.g (),
		clue.gen_clues.marks (),
		clue.gen_clues.registers (),
		clue.gen_clues.windows (),
		clue.gen_clues.z (),
	},
}
