--- ===========================
--- User Commands
--- ===========================

vim.api.nvim_create_user_command ('PackUp', function(opts)
	if #opts.fargs == 0 then
		vim.pack.update ()
	else
		vim.pack.update (opts.fargs)
	end
end, { nargs = '*', desc = 'Update plugins.' })
