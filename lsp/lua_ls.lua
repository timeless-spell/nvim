--- @type vim.lsp.Config
return {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', { '.stylua.toml', 'stylua.toml' }, 'selene.toml', ',git' },
}
