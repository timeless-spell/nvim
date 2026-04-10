Angju.later(function ()
	vim.pack.add { 'https://github.com/brenoprata10/nvim-highlight-colors' }

	require('nvim-highlight-colors').setup {
		render = 'background',
		-- virtual_symbol = '',
		exclude_filetypes = {},
		exclude_buftypes = {},
	}
end)
