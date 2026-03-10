MiniDeps.now(function ()
	MiniDeps.add {
		source = 'scottmckendry/cyberdream.nvim',
	}

	require('cyberdream').setup {
		transparent = true,
		italic_comments = true,
	}

	Angju.set_keymap('<Leader><Space>c', '<CMD>colorscheme cyberdream<CR>', 'Colorscheme: Cyberdream')
end)
