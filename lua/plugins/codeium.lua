return {
	"Exafunction/codeium.nvim",
	name = "Codeium",
	dependencies = {
		{ "nvim-lua/plenary.nvim", name = "Plenary" },
		{ "hrsh7th/nvim-cmp", name = "Cmp" },
	},
	config = function()
		require("codeium").setup({})
	end,
}
