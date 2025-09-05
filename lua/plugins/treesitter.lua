MiniDeps.now (function ()
  MiniDeps.add ({
    source = 'nvim-treesitter/nvim-treesitter',
    depends = {
      'nvim-treesitter/nvim-treesitter-context',
    },
    checkout = 'main',
    hooks = {
      post_checkout = function ()
        vim.cmd ('TSUpdate')
      end,
    },
  })

  require ('nvim-treesitter').install ({ 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' })

  vim.api.nvim_create_autocmd ('FileType', {
    group = vim.api.nvim_create_augroup ('nvim-treesitter', { clear = true }),
    pattern = { '*.lua', '*.sh', '*.md', '*.fish', '*.vim' },
    callback = function ()
      -- syntax highlighting, provided by Neovim
      vim.treesitter.start ()
      -- folds, provided by Neovim
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- indentation, provided by nvim-treesitter (experimental)
      -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

  require ('treesitter-context').setup ()
end)

--
-- Treesitter Text Objects
--
MiniDeps.later (function ()
  MiniDeps.add ({
    source = 'nvim-treesitter/nvim-treesitter-textobjects',
    checkout = 'main',
  })

  require ('nvim-treesitter-textobjects').setup ()
end)
