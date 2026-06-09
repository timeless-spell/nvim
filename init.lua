_G.Ang = require  'globals'

require  'options'
require  'keymaps'
require  'diagnostic'

-- ==============================
-- Autocmds
-- ==============================
local new_autocmd = vim.api.nvim_create_autocmd

new_autocmd ('VimEnter', { command = 'colorscheme cyberdream', desc = 'Set colorscheme' })

-- NOTE: Implemented with yanky.nvim
-- new_autocmd ('TextYankPost', { callback = function() vim.hl.on_yank () end, desc = 'Highlight when yanking text' })

-- Autocommand for plugins that need to build or run commands after installation.
new_autocmd ('PackChanged', {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= 'install' and kind ~= 'update' then return end

		if name == 'telescope-fzf-native.nvim' and vim.fn.executable  'make' == 1 then
			Ang.run_build (name, { 'make' }, ev.data.path)
			return
		end

		if name == 'LuaSnip' then
			if vim.fn.has  'win32' ~= 1 and vim.fn.executable  'make' == 1 then
				Ang.run_build (name, { 'make', 'install_jsregexp' }, ev.data.path)
			end
			return
		end

		if name == 'nvim-treesitter' then
			if not ev.data.active then vim.cmd.packadd  'treesitter-parser-registry' end
			if not ev.data.active then vim.cmd.packadd  'nvim-treesitter' end
			vim.cmd  'TSUpdate'
			return
		end
	end,
})
-- ==============================
-- User cmds
-- ==============================

vim.api.nvim_create_user_command ('PackUp', function(opts)
	if #opts.fargs == 0 then
		vim.pack.update ()
	else
		vim.pack.update (opts.fargs)
	end
end, { nargs = '*', desc = 'Update plugins' })
