vim.cmd 'packadd cubes.nvim'

require('cubes').setup {
    integrations = {
        pnpm = true,
    },
}
