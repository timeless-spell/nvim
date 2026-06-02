vim.diagnostic.config  {
	update_in_insert = false,
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = false,
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float  {
				bufnr = bufnr,
				scope = 'cursor',
				focus = false,
			}
		end,
	},
}

local diagnostics_visible = true

local function toggleDiagnostics()
	if diagnostics_visible then
		vim.diagnostic.hide ()
		diagnostics_visible = false
	else
		vim.diagnostic.show ()
		diagnostics_visible = true
	end
end

--- @type ang.Keymap[]
local diagnostic_keymaps = {
	{ keys = '<Leader>dl', func = vim.diagnostic.setloclist, desc = 'Open diagnostic Location list' },
	{ keys = '<Leader>dq', func = vim.diagnostic.setqflist, desc = 'Open diagnostic Quickfix list' },
	{ keys = '<Leader>df', func = vim.diagnostic.open_float, desc = 'Open diagnostic Float' },
	{ keys = '<Leader>dt', func = toggleDiagnostics, desc = 'Hide/Show diagnostic' },
}

Ang.tbl_map (diagnostic_keymaps)
