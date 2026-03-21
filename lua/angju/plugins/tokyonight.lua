MiniDeps.now(function ()
	MiniDeps.add { source = 'folke/tokyonight.nvim' }

	Angju.set_keymap(
		'<Leader><Space>ct',
		'<CMD>colorscheme tokyonight-moon<CR>',
		'Colorscheme:Tokyonight Moon'
	)
end)
