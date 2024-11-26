return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		opts = {},
	},
	opts = {
		ensure_installed = {
			"bash",
			"fish",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"regex",
		},
		auto_install = true,
		highlight = {
			enable = true,
			-- additional_vim_regex_highlighting = { 'ruby' },
		},
		indent = {
			enable = true,
			-- disable = { 'ruby' }
		},
	},
}
