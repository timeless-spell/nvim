return {
	"luckasRanarison/tailwind-tools.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-treesitter/nvim-treesitter", "onsails/lspkind.nvim", "hrsh7th/nvim-cmp" },
	config = function()
		require("cmp").config.formatting = {
			format = require("lspkind").cmp_format({
				before = require("tailwind-tools.cmp").lspkind_format,
			}),
		}
	end,
}
