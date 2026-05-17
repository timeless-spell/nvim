Ang.pack_add  'neovim/nvim-lspconfig'

vim.api.nvim_create_autocmd ('LspAttach', {
	group = vim.api.nvim_create_augroup ('lsp-attach', { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id (event.data.client_id)

		if client and client:supports_method ('textDocument/documentHighlight', event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup ('lsp-highlight', { clear = false })

			vim.api.nvim_create_autocmd ({ 'CursorHold', 'CursorHoldI' }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
				desc = 'Highlight word under cursor',
			})

			vim.api.nvim_create_autocmd ({ 'CursorMoved', 'CursorMovedI' }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd ('LspDetach', {
				group = vim.api.nvim_create_augroup ('lsp-detach', { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references ()
					vim.api.nvim_clear_autocmds  { group = 'lsp-highlight', buffer = event2.buf }
				end,
			})
		end

		if client and client:supports_method ('textDocument/inlayHint', event.buf) then
			Ang.map (
				'<leader>lH',
				function() vim.lsp.inlay_hint.enable (not vim.lsp.inlay_hint.is_enabled  { bufnr = event.buf }) end,
				'Toggle Inlay Hints'
			)
		end
	end,
})

local function enabled_servers(servers_config)
	local enabled = {}

	for server, config in pairs (servers_config) do
		vim.lsp.config[server] = config
		if server ~= '*' then table.insert (enabled, server) end
	end

	return enabled
end

local servers = {
	['*'] = {},
	lua_ls = {},
	harper_ls = {
		settings = {
			['harper-ls'] = {
				linters = {
					SentenceCapitalization = false,
					SpellCheck = false,
				},
			},
		},
	},
}

vim.lsp.enable (enabled_servers (servers))
