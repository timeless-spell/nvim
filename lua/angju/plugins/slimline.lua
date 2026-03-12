MiniDeps.now(function ()
	MiniDeps.add 'sschleemilch/slimline.nvim'
	require('slimline').setup {
		spaces = {
			components = '─',
			left = '─',
			right = '─',
		},
	}
end)
