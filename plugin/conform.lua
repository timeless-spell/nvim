Ang.pack_add  'stevearc/conform.nvim'

local conform = require  'conform'

conform.setup  {
	default_format_opts = {
		lsp_format = 'fallback',
	},
	format_on_save = {
		lsp_foramt = 'fallback',
		timeout_ms = 500,
	},
	formatters_by_ft = {
		lua = { 'stylua' },
		rust = { 'rustfmt' },
	},
}

Ang.map ('<Leader><Space>f', function() conform.format  { async = true } end, 'Format buffer [Conform]')
