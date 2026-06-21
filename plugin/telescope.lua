local add = Ang.pack_add

add  'nvim-telescope/telescope-ui-select.nvim'
add  'jvgrootveld/telescope-zoxide'
add  'nvim-telescope/telescope-file-browser.nvim'
add  'nvim-telescope/telescope-fzf-native.nvim'
add  'nvim-telescope/telescope.nvim'
add  'nvim-lua/plenary.nvim'

local telescope = require  'telescope'
local actions = require  'telescope.actions'
local builtin = require  'telescope.builtin'
local utils = require  'telescope.utils'

local telescope_config = {
	defaults = {
		layout_config = {
			horizontal = { prompt_position = 'top' },
		},
		prompt_prefix = '󰍉 ',
		selection_caret = '󰜴 ',
		entry_prefix = ' ',
		multi_icon = ' ',
		mappings = {
			i = {
				['<c-down>'] = actions.cycle_history_next,
				['<c-up>'] = actions.cycle_history_prev,
				['<c-q>'] = actions.close,
			},
		},
	},
	extensions = {
		['file_browser'] = {},
		['ui-select'] = require ('telescope.themes').get_dropdown (),
		['fzf'] = {},
		['zoxide'] = {
			mappings = {
				['<C-b>'] = {
					keepinsert = true,
					action = function(selection)
						require ('telescope').extensions.file_browser.file_browser  {
							cwd = selection.path,
						}
					end,
				},
			},
		},
	},
}

telescope.setup (telescope_config)

for extension, _ in pairs (telescope_config.extensions) do
	pcall (require ('telescope').load_extension, extension)
end

---@type ang.Keymap[]
local telescope_keymaps = {
	{
		keys = '<leader>sf',
		func = builtin.find_files,
		desc = 'Search Files [Telescope]',
	},
	{
		keys = '<leader>sc',
		func = function()
			builtin.find_files  {
				cwd = utils.buffer_dir (),
			}
		end,
		desc = 'Search Files in current buffer location [Telescope]',
	},
	{
		keys = '<leader>so',
		func = builtin.oldfiles,
		desc = 'Search Old Files [Telescope]',
	},
	{
		keys = '<leader>sg',
		func = builtin.live_grep,
		desc = 'Search by Grep [Telescope]',
	},
	{
		keys = '<leader>sw',
		func = builtin.grep_string,
		desc = 'Search current Word [Telescope]',
	},
	{
		keys = '<leader>s/',
		func = builtin.current_buffer_fuzzy_find,
		desc = '[/] Fuzzily search in current buffer [Telescope]',
	},
	{
		keys = '<leader>sq',
		func = builtin.quickfix,
		desc = 'Quiqfix [Telescope]',
	},
	{
		keys = '<leader>s<leader>',
		func = builtin.buffers,
		desc = 'Search Open Buffers [Telescope]',
	},
	{
		keys = '<leader>sh',
		func = builtin.help_tags,
		desc = 'Search Help [Telescope]',
	},
	{
		keys = '<leader>sn',
		func = function()
			builtin.find_files  {
				cwd = vim.fn.stdpath  'config',
			}
		end,
		desc = 'Search Neovim Files [Telescope]',
	},
	{
		keys = '<leader>sk',
		func = builtin.keymaps,
		desc = 'Search Keymaps [Telescope]',
	},
	{
		keys = '<leader>sb',
		func = telescope.extensions.file_browser.file_browser,
		desc = 'File Browser [Telescope]',
	},
	{
		keys = '<leader>sz',
		func = telescope.extensions.zoxide.list,
		desc = 'Zoxide [Telescope]',
	},
}

Ang.tbl_map (telescope_keymaps)
