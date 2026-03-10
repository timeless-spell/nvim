MiniDeps.now(function ()
	MiniDeps.add {
		source = 'nvim-treesitter/nvim-treesitter',
		depends = {
			'nvim-treesitter/nvim-treesitter-context',
		},
		checkout = 'main',
		hooks = {
			post_checkout = function ()
				vim.cmd 'TSUpdate'
			end,
		},
	}

	require('nvim-treesitter').install {
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
	}

	vim.api.nvim_create_autocmd('FileType', {
		group = vim.api.nvim_create_augroup('nvim-treesitter', { clear = true }),
		pattern = {
			'c',
			'lua',
			'bash',
			'markdown',
			'fish',
			'vim',
			'yaml',
			'toml',
			'javascript',
			'typescript',
			'javascriptreact',
			'typescriptreact',
			'java',
		},
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
end)

--
-- Treesitter Text Objects
--
MiniDeps.later(function ()
	MiniDeps.add {
		source = 'nvim-treesitter/nvim-treesitter-textobjects',
		checkout = 'main',
	}

	require('nvim-treesitter-textobjects').setup()
end)
