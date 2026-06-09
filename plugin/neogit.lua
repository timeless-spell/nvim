local add = Ang.pack_add
add  'NeogitOrg/neogit'
add  'esmuellert/codediff.nvim'
add  'm00qek/baleia.nvim'

vim.api.nvim_create_user_command ('BaleiaLogs', vim.cmd.messages, { bang = true })

Ang.map ('<leader>gn', require ('neogit').open, 'Open [ Neogit ]')
