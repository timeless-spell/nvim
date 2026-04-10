Angju.later(function ()
	vim.pack.add { 'https://github.com/NeogitOrg/neogit' }

	local neogit = require 'neogit'

	Angju.set_keymap('<leader>gn', function ()
		neogit.open()
	end, 'Open [ Neogit ]')
end)
