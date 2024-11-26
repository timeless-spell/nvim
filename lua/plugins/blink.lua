return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = {
		{ "saghen/blink.compat", version = "*" },
		"rafamadriz/friendly-snippets",
		"niuiic/blink-cmp-rg.nvim",
		"hrsh7th/cmp-emoji",
		"chrisgrieser/cmp-nerdfont",
		"mtoohey31/cmp-fish",
	},
	version = "v0.*",
	---
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		windows = {
			autocomplete = {
				border = "padded",
				windblend = 20,
			},
			documentation = {
				border = "padded",
				windblend = 20,
				auto_show = true,
				auto_show_delay_ms = 50,
			},
			signature_help = {
				border = "padded",
			},
			highlight = {
				use_nvim_cmp_as_default = true,
			},
		},
		sources = {
			completion = {
				enabled_providers = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"lazydev",
					"ripgrep",
					"emoji",
					"nerdfont",
					"fish",
				},
			},
			providers = {
				lsp = { fallback_for = { "lazydev" } },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
				ripgrep = {
					module = "blink-cmp-rg",
					name = "Ripgrep",
				},

				emoji = {
					name = "emoji",
					module = "blink.compat.source",
					transform_items = function(context, items)
						local kind = require("blink.cmp.types").CompletionItemKind.Text

						for i = 1, #items do
							items[i].kind = kind
						end

						return items
					end,
				},
				nerdfont = {
					name = "nerdfont",
					module = "blink.compat.source",
					transform_items = function(context, items)
						local kind = require("blink.cmp.types").CompletionItemKind.Text

						for i = 1, #items do
							items[i].kind = kind
						end

						return items
					end,
				},
				fish = {
					name = "fish",
					module = "blink.compat.source",
					score_offset = -3,
				},
			},
		},
	},
}
