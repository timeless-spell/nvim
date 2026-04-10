Angju.now(function ()
	vim.pack.add { 'https://github.com/scottmckendry/cyberdream.nvim' }

	require('cyberdream').setup {
		transparent = true,
		italic_comments = true,
	}

	vim.cmd 'colorscheme cyberdream'

	Angju.set_keymap('<Leader><Space>cc', '<CMD>colorscheme cyberdream<CR>', 'Colorscheme: Cyberdream')
end)
