Angju.now(function ()
	vim.pack.add { 'https://github.com/sschleemilch/slimline.nvim' }

	require('slimline').setup {
		spaces = {
			components = '─',
			left = '─',
			right = '─',
		},
	}

	vim.opt.fillchars = {
		stl = '─',
	}

	vim.o.laststatus = 3
end)
