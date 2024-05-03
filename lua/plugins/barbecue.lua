return {
	"utilyre/barbecue.nvim",
	name = "Barbecue",
	version = "*",
	dependencies = {
		{ "SmiteshP/nvim-navic", name = "Navic" },
		{ "nvim-tree/nvim-web-devicons", name = "Web Devicons" },
	},
	config = function()
		require("barbecue").setup({})
	end,
}
