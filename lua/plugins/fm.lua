return {
  'is0n/fm-nvim',
  config = function()
    vim.keymap.set('n', 'ff', '<cmd>Fzf<cr>', { noremap = true, silent = true, desc = 'Open Fzf' })
    vim.keymap.set('n', 'rr', '<cmd>Ranger<cr>', { noremap = true, silent = true, desc = 'Open Ranger' })
    require('fm-nvim').setup({
      ui = {
        float = {
          border = 'single',
          height = 0.9,
          width = 0.9,
        },
      },
    })
  end,
}
