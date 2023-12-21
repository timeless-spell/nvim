return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require('null-ls')

    vim.keymap.set('n', '<leader>ff', '<cmd>Format<cr>', { desc = '[F]ormat [F]ile' })

    local sources = {
      -- [[ Formatters ]]
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.beautysh,
      null_ls.builtins.formatting.deno_fmt.with({
        condition = function(utils)
          return utils.root_has_file({ 'deno.json', 'deno.jsonc' })
        end,
      }),
      null_ls.builtins.formatting.prettierd.with({
        condition = function(utils)
          return utils.root_has_file({ 'prettierrc', 'prettierrc.json', 'prettier.config.json', 'package.json' })
        end,
      }),
    }

    null_ls.setup({
      sources = sources,
    })
  end,
}
