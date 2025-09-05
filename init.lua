-- [ nvim-mini ]
local path_package = vim.fn.stdpath ('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.uv.fs_stat (mini_path) then
  vim.cmd ('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/nvim-mini/mini.nvim',
    mini_path,
  }
  vim.system (clone_cmd)
  vim.cmd ('packadd mini.nvim | helptags ALL')
  vim.cmd ('echo "Installed `mini.nvim`" | redraw')
end

require ('mini.deps').setup ({ path = { package = path_package } })

--
-- TODO: Automatize the requirement of modules
--

-- [ Config ]

--- @type string[]
local config = {
  'globals',
  'options',
  'keymaps',
  'lsp',
  'diagnostics',
}

for _, value in pairs (config) do
  pcall (require, 'config.' .. value)
end

-- [ Plugins ]

--- @type string[]
local plugins = {
  'lib',
  'mini',
  'notify',
  'treesitter',
  'blink',
  'conform',
  'endhints',
  'fzf',
  'telescope',
  'view',
  'neogit',
  'lint',
  'todo-comments',
  'yanky',
  'substitute',
  'flash',
  'which-key',
  'fff',
  'highlight-colors',
  'hlchunk',
  'spider',
  'lazygit',
  'guess-indent',
  'autotag',
  'quicker',
  'bqf',
}

for _, value in pairs (plugins) do
  pcall (require, 'plugins.' .. value)
end

-- [ Autocommands ]

--- @type string[]
local autocmds = {
  'highlight',
  'lsp',
}

for _, value in pairs (autocmds) do
  pcall (require, 'autocmds.' .. value)
end
