Angju.later(function ()
	vim.pack.add { 'https://github.com/neovim/nvim-lspconfig' }

	---@param servers_config table<string, vim.lsp.Config>
	---@return string[]
	local function enabled_servers (servers_config)
		local enabled = {}

		for server, config in pairs(servers_config) do
			vim.lsp.config[server] = config
			if server ~= '*' then table.insert(enabled, server) end
		end

		return enabled
	end

	-- ===========================================================================
	-- Language Settings
	-- ===========================================================================

	-- Typescript and Javascript  (denols, ts_ls)
	-- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md
	local typescript_settings = {
		['implicitProjectCOnfiguration.target'] = 'es2024',
		inlayHints = {
			includeInlayParameterNameHints = 'all',
			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayVariableTypeHintsWhenTypeMatchesName = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
		},
		['implementationsCodeLens.enable'] = true,
		['referencesCodeLens.enable'] = true,
		['referencesCodeLens.showOnAllFunctions'] = true,
	}

	-- ===========================================================================
	-- LSP Config
	-- ===========================================================================

	---@type table<string, vim.lsp.Config>
	local servers = {
		['*'] = {},
		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'MiniMisc' },
						disable = { 'missing-fields' },
					},
				},
			},
		},
		ts_ls = {
			settings = {
				typescript = typescript_settings,
				javascript = typescript_settings,
			},
		},
		denols = {
			settings = {
				typescript = typescript_settings,
				javascript = typescript_settings,
			},
		},
		biome = {},
		taplo = {},
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

	vim.lsp.enable(enabled_servers(servers))

	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
		callback = function (event)
			---@type angju.keymap.Set[]
			local keymaps = {
				{
					keys = '<leader>lgd',
					func = vim.lsp.buf.definition,
					desc = 'LSP: [G]oto [D]efinition',
					buffer = event.buf,
				},
				{
					keys = '<leader>lgD',
					func = vim.lsp.buf.declaration,
					desc = 'LSP: [G]oto [D]eclaration',
					buffer = event.buf,
				},
				{
					keys = '<leader>lgi',
					func = vim.lsp.buf.implementation,
					desc = 'LSP: [G]oto Implementation',
					buffer = event.buf,
				},
				{
					keys = '<leader>lgt',
					func = vim.lsp.buf.type_definition,
					desc = 'LSP: [G]oto [T]ype Definition',
					buffer = event.buf,
				},
				{
					keys = '<leader>lh',
					func = vim.lsp.buf.signature_help,
					desc = 'LSP: Signature [H]elp',
					buffer = event.buf,
				},
				{
					keys = '<leader>lr',
					func = vim.lsp.buf.references,
					desc = 'LSP: [R]eferences',
					buffer = event.buf,
				},
				{
					keys = '<leader>ln',
					func = vim.lsp.buf.rename,
					desc = 'LSP: Re[n]ame,',
					buffer = event.buf,
				},
				{
					keys = '<leader>la',
					func = vim.lsp.buf.code_action,
					desc = 'LSP: Code [A]ction',
					buffer = event.buf,
				},
				{
					keys = '<leader>lw',
					func = vim.lsp.buf.workspace_symbol,
					desc = 'LSP: [W]orkspace Symbol',
					buffer = event.buf,
				},
				{
					keys = '<leader>ld',
					func = vim.lsp.buf.document_symbol,
					desc = 'LSP: [D]ocument Symbol',
					buffer = event.buf,
				},
			}

			Angju.set_table_keymap(keymaps)

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client:supports_method('textDocument/documentHighlight', event.buf) then
				local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

				vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
					desc = 'Highlight word under cursor',
				})

				vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd('LspDetach', {
					group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
					callback = function (event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
					end,
				})
			end

			if client and client:supports_method('textDocument/inlayHint', event.buf) then
				Angju.set_keymap('<leader>lH', function ()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
				end, 'Toggle Inlay Hints')
			end
		end,
	})
end)
