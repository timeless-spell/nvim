Ang.pack_add  'ibhagwan/fzf-lua'

local fzf = require  'fzf-lua'

fzf.setup  {
	files = {
		previewer = 'bat',
	},
	winopts = {
		height = 0.95,
		width = 0.90,
	},
}

local fzf_keymaps = {
	--
	-- Buffers and Files
	--
	{ keys = '<Leader>ff', func = fzf.files, desc = 'Files [Fzf]' },
	{ keys = '<Leader>fx', func = function() fzf.files  { cwd = '~', hidden = false } end, desc = 'Global [Fzf]' },
	{ keys = '<Leader>f<Space>', func = fzf.buffers, desc = 'Buffers [Fzf]' },
	{ keys = '<Leader>fo', func = fzf.oldfiles, desc = 'Recent files [Fzf]' },
	{ keys = '<Leader>fq', func = fzf.quickfix, desc = 'Quickfix list [Fzf]' },
	{ keys = '<Leader>fQ', func = fzf.quickfix_stack, desc = 'Quickfix stack [Fzf]' },
	{ keys = '<Leader>fc', func = fzf.loclist, desc = 'Loclist list [Fzf]' },
	{ keys = '<Leader>fC', func = fzf.loclist_stack, desc = 'Loclist stack [Fzf]' },
	{ keys = '<Leader>fn', func = fzf.lines, desc = 'Open buffers lines [Fzf]' },
	{ keys = '<Leader>fN', func = fzf.blines, desc = 'Current buffer lines [Fzf]' },
	{ keys = '<Leader>fT', func = fzf.treesitter, desc = 'Current buffer Treesitter symbols [Fzf]' },
	{ keys = '<Leader>ft', func = fzf.tabs, desc = 'Open tabs [Fzf]' },
	{ keys = '<Leader>fa', func = fzf.args, desc = 'Argument list [Fzf]' },

	--
	-- Search word
	--
	{ keys = '<Leader>fwg', func = fzf.grep, desc = 'Search pattern [Fzf]' },
	{ keys = '<Leader>fwl', func = fzf.grep_last, desc = 'Search last pattern [Fzf]' },
	{ keys = '<Leader>fww', func = fzf.grep_cword, desc = 'Search word under cursor [Fzf]' },
	{ keys = '<Leader>fwW', func = fzf.grep_cWORD, desc = 'Search WORD under cursor [Fzf]' },
	{ keys = '<Leader>fwV', func = fzf.grep_visual, desc = 'Search visual selection [Fzf]' },
	{ keys = '<Leader>fwp', func = fzf.grep_project, desc = 'Search all project lines [Fzf]' },
	{ keys = '<Leader>fwb', func = fzf.grep_curbuf, desc = 'Search current buffer lines [Fzf]' },
	{ keys = '<Leader>fwq', func = fzf.grep_quickfix, desc = 'Search the quickfix list [Fzf]' },
	{ keys = '<Leader>fwc', func = fzf.grep_loclist, desc = 'Search the loccation list [Fzf]' },
	{ keys = '<Leader>fwf', func = fzf.lgrep_curbuf, desc = 'Live grep curent buffer [Fzf]' },
	{ keys = '<Leader>fwx', func = fzf.lgrep_quickfix, desc = 'Live grep the quickfix list [Fzf]' },
	{ keys = '<Leader>fws', func = fzf.lgrep_loclist, desc = 'Live grep the location list[Fzf]' },
	{ keys = '<Leader>fwv', func = fzf.live_grep, desc = 'Live grep current project [Fzf]' },
	{ keys = '<Leader>fwr', func = fzf.live_grep_resume, desc = 'Live grep last search [Fzf]' },
	{ keys = '<Leader>fwo', func = fzf.live_grep_glob, desc = "Live grep 'rg --glob' [Fzf]" },
	{ keys = '<Leader>fwG', func = fzf.live_grep_native, desc = 'Live grep native [Fzf]' },

	--
	-- LSP
	--
	{ keys = '<Leader>flr', func = fzf.lsp_references, desc = 'LSP References [Fzf]' },
	{ keys = '<Leader>fld', func = fzf.lsp_definitions, desc = 'LSP Definitions [Fzf]' },
	{ keys = '<Leader>flD', func = fzf.lsp_declarations, desc = 'LSP Declarations [Fzf]' },
	{ keys = '<Leader>flt', func = fzf.lsp_typedefs, desc = 'LSP Type Definitions [Fzf]' },
	{ keys = '<Leader>fli', func = fzf.lsp_implementations, desc = 'LSP Implementations [Fzf]' },
	{ keys = '<Leader>fls', func = fzf.lsp_document_symbols, desc = 'LSP Document Symbols [Fzf]' },
	{ keys = '<Leader>flw', func = fzf.lsp_workspace_symbols, desc = 'LSP Workspace Symbols [Fzf]' },
	{ keys = '<Leader>flW', func = fzf.lsp_live_workspace_symbols, desc = 'LSP Workspace Symbols (live query) [Fzf]' },
	{ keys = '<Leader>fla', func = fzf.lsp_code_actions, desc = 'LSP Code Actions [Fzf]' },
	{ keys = '<Leader>flF', func = fzf.lsp_finder, desc = 'LSP Locations, combined view [Fzf]' },
	{ keys = '<Leader>flg', func = fzf.lsp_document_diagnostics, desc = 'LSP Diagnostics Document [Fzf]' },
	{ keys = '<Leader>flG', func = fzf.lsp_workspace_diagnostics, desc = 'LSP Diagnostics Workspace [Fzf]' },

	--
	-- Zoxide
	--
	{ keys = '<Leader>fZ', func = fzf.zoxide, desc = 'Zoxide [Fzf]' },
}

Ang.tbl_map (fzf_keymaps)
