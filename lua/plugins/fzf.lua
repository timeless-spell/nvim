return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>Fsf",
			function()
				require("fzf-lua").files({})
			end,
			desc = "Fzf [ Files ]",
		},
		{
			"<leader>Fz",
			function()
				require("fzf-lua").files({ cwd = "~" })
			end,
			desc = "Fzf [ Global ]",
		},
		{
			"<leader>Fsc",
			function()
				require("fzf-lua").files({ cwd = "~/.config" })
			end,
			desc = "Fzf [ Config ]",
		},
		{
			"<leader>Fds",
			function()
				require("fzf-lua").lsp_document_symbols({})
			end,
			desc = "Fzf [ LSP Document Symbols ]",
		},
	},
	opts = {
		"fzf-native",
		winopts = { fullscreen = true },
		files = {
			previewer = "bat",
		},
	},
}
