local add = Ang.pack_add

-- ==============================
-- Cyberdream
-- ==============================
add  'scottmckendry/cyberdream.nvim'

require ('cyberdream').setup  {
	italic_comments = true,
	borderless_pickers = true,
	cache = true,
	extensions = {
		default = true,
	},
}

vim.api.nvim_create_autocmd ('VimEnter', {
	callback = function()
		local mini_exists = vim.pack.get  { 'mini.nvim' }
		if mini_exists then
			if vim.g.cyberdream_opts.borderless_pickers then MiniClue.config.window.config.border = 'none' end
		end
	end,
})

-- ==============================
-- Tokyonight
-- ==============================
add  'folke/tokyonight.nvim'

require ('tokyonight').setup  {
	styles = {
		keywords = { italic = false },
	},
}
