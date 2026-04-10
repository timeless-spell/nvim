Angju.now_if_args(function ()
	local ts_update = function ()
		vim.cmd 'TSUpdate'
	end
	Angju.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

	vim.pack.add {
		{ src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
		{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
		'https://github.com/nvim-treesitter/nvim-treesitter-context',
	}

	local treesitter = require 'nvim-treesitter'

	local languages = {
		'bash',
		'fish',
		'c',
		'diff',
		'html',
		'lua',
		'luadoc',
		'markdown',
		'markdown_inline',
		'query',
		'vim',
		'vimdoc',
		'yaml',
		'toml',
		'javascript',
		'typescript',
		'jsx',
		'tsx',
		'java',
	}

	treesitter.install(languages)
	treesitter.update(languages)

	vim.api.nvim_create_autocmd('FileType', {
		group = vim.api.nvim_create_augroup('nvim-treesitter', { clear = true }),
		pattern = languages,
		callback = function ()
			-- syntax highlighting, provided by Neovim
			vim.treesitter.start()

			-- folds, provided by Neovim
			-- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			-- vim.wo[0][0].foldmethod = 'expr'

			-- indentation, provided by nvim-treesitter (experimental)
			-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})

	require('treesitter-context').setup()
	require('nvim-treesitter-textobjects').setup()
end)
