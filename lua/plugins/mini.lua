return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		local mini_surround = require("mini.surround")
		mini_surround.setup({})

		local mini_move = require("mini.move")
		mini_move.setup({})

		local mini_pairs = require("mini.pairs")
		mini_pairs.setup({})
	end,
}
