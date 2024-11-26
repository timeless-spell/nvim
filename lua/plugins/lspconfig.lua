return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"saghen/blink.cmp",
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("<leader>lgd", vim.lsp.buf.definition, "[G]oto Definition")
				map("<leader>lgD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("<leader>lgi", vim.lsp.buf.implementation, "[G]oto Implementation")
				map("<leader>lgt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
				map("<leader>lsh", vim.lsp.buf.signature_help, "[S]ignature [H]elp")
				map("<leader>lre", vim.lsp.buf.references, "[Re]ferences")
				map("<leader>lrn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>lca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("<leader>lws", vim.lsp.buf.workspace_symbol, "[W}orkspace [S]ymbol")
				map("<leader>lds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbol")
				map("<leader>ll", vim.diagnostic.setloclist, "Open diagnostic [L]ocation list")
				map("<leader>lq", vim.diagnostic.setqflist, "Open diagnostic [Q]uickfix list")
				map("<leader>le", vim.diagnostic.open_float, "Open Floating Diagnostic Message")
				map("<leader>ln", vim.diagnostic.get_next, "Next diagnostic message")
				map("<leader>lp", vim.diagnostic.get_prev, "Previous diagnostic message")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>ih", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "Toggle [I]nlay [H]ints")
				end
			end,
		})

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						hint = {
							enable = true,
						},
					},
				},
			},
		}

		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"taplo",
		})

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					lspconfig[server_name].setup(server)
				end,
			},
		})
	end,
}
