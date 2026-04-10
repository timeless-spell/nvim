Angju.now(function ()
	vim.pack.add { 'https://github.com/folke/tokyonight.nvim' }

	Angju.set_keymap(
		'<Leader><Space>ct',
		'<CMD>colorscheme tokyonight-moon<CR>',
		'Colorscheme:Tokyonight Moon'
	)
end)
