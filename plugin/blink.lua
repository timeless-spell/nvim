local add = Ang.pack_add

-- ==============================
-- LuaSnip
-- ==============================
add  { src = 'L3MON4D3/LuaSnip', version = vim.version.range  '2.*' }

require ('luasnip').setup  {
	update_events = { 'TextChanged', 'TextChangedI' },
	enable_autosnippets = true,
}

require ('luasnip.loaders.from_lua').load  { paths = vim.fn.stdpath  'config' .. '/snippets' }

-- ==============================
-- Lazydev
-- ==============================
add  'folke/lazydev.nvim'

require ('lazydev').setup  {}

-- ==============================
-- Blink.cmp
-- ==============================
add  'MahanRahmati/blink-nerdfont.nvim'
add  'moyiz/blink-emoji.nvim'
add  { src = 'saghen/blink.cmp', version = vim.version.range  '1.*' }

--- @type blink.cmp.Config
local blink_config = {
	cmdline = {
		enabled = false,
	},
	completion = {
		menu = {
			draw = {
				components = {
					-- NOTE: https://github.com/brenoprata10/nvim-highlight-colors#blinkcmp-integration
					-- customize the drawing of kind icons
					kind_icon = {
						text = function(ctx)
							-- default kind icon
							local icon = ctx.kind_icon
							-- if LSP source, check for color derived from documentation
							if ctx.item.source_name == 'LSP' then
								local color_item = require ('nvim-highlight-colors').format (
									ctx.item.documentation,
									{ kind = ctx.kind }
								)
								if color_item and color_item.abbr ~= '' then icon = color_item.abbr end
							end
							return icon .. ctx.icon_gap
						end,
						highlight = function(ctx)
							-- default highlight group
							local highlight = 'BlinkCmpKind' .. ctx.kind
							-- if LSP source, check for color derived from documentation
							if ctx.item.source_name == 'LSP' then
								local color_item = require ('nvim-highlight-colors').format (
									ctx.item.documentation,
									{ kind = ctx.kind }
								)
								if color_item and color_item.abbr_hl_group then highlight = color_item.abbr_hl_group end
							end
							return highlight
						end,
					},
				},
			},
		},
		documentation = {
			auto_show = true,
			window = { border = 'solid' },
		},
	},
	snippets = { preset = 'luasnip' },
	sources = {
		default = {
			'lsp',
			'path',
			'snippets',
			'buffer',
			'emoji',
			'nerdfont',
			'lazydev',
		},
		providers = {
			lazydev = {
				name = 'lazydev',
				module = 'lazydev.integrations.blink',
				score_offset = 100,
			},
			nerdfont = {
				module = 'blink-nerdfont',
				name = 'Nerd Fonts',
				score_offset = 0,
				opts = {
					inset = true,
					trigger = ':',
				},
			},
			emoji = {
				module = 'blink-emoji',
				name = 'Emoji',
				score_offset = 0,
				opts = {
					insert = true,
					trigger = ':',
				},
				-- should_show_items = function() return vim.tbl_contains ({ 'gitcommit', 'markdown' }, vim.o.filetype) end,
			},
		},
	},
}

require ('blink.cmp').setup (blink_config)
