Ang.pack_add  'gbprod/substitute.nvim'

local subs = require  'substitute'
local range = require  'substitute.range'
local exchange = require  'substitute.exchange'

subs.setup  {
	on_substitute = function() require ('yanky.integration').substitute () end,
}

local subs_keymaps = {
	-- Substitute
	{ keys = 'so', func = subs.operator, desc = 'Operator [Substitute]' },
	{ keys = 'sl', func = subs.line, desc = 'Line [Substitute]' },
	{ keys = 'se', func = subs.eol, desc = 'End of Line [Substitute]' },
	{ keys = 'sv', func = subs.visual, desc = 'Visual [Substitute]', mode = 'x' },
	-- Range
	{ keys = 'sO', func = range.operator, desc = 'Operator Range [Substitute]' },
	{ keys = 'sw', func = range.word, desc = 'Word Range [Substitute]' },
	{ keys = 'sV', func = range.visual, desc = 'Visual Range [Substitute]', mode = 'x' },
	-- Exchange
	{ keys = 'sx', func = exchange.operator, desc = 'Operator Exchange [Substitute]' },
	{ keys = 'sxl', func = exchange.line, desc = 'Line Exchange [Substitute]' },
	{ keys = 'sx', func = exchange.visual, desc = 'Visual Exchange [Substitute]', mode = 'x' },
	{ keys = 'sxq', func = exchange.cancel, desc = 'Cancel Exchange [Substitute]' },
}

Ang.tbl_map (subs_keymaps)
