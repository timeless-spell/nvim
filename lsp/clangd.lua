--- @type vim.lsp.Config
return {
	cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
	cmd_env = { CLANGD_TRACE = vim.fn.stdpath  'log' },
	filetypes = { 'c', 'cpp' },
	root_markers = {
		'.clangd',
		'.clang-tidy',
		'.clang-format',
		'compile_commands.json',
		'compile_flags.txt',
		'configure.ac',
		'xmake.lua',
		'.git',
	},
}
