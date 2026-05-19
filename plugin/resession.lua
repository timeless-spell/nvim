Ang.pack_add  'stevearc/resession.nvim'

local resession = require  'resession'

resession.setup  {
	autosave = {
		enabled = true,
		interval = 60,
		notify = true,
	},
}

--- @type ang.Keymap[]
local resession_keymaps = {
	{ keys = '<Leader>rs', func = resession.save, desc = 'Save session [Resession]' },
	{ keys = '<Leader>rl', func = resession.load, desc = 'Load session [Resession]' },
	{ keys = '<Leader>rd', func = resession.delete, desc = 'Delete session [Resession]' },
}

Ang.tbl_map (resession_keymaps)

vim.api.nvim_create_autocmd ('VimLeavePre', {
	callback = function() resession.save  'last' end,
})
