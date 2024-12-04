return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")
		local utils = require("telescope.utils")
		local actions = require("telescope.actions")
		local map = vim.keymap.set

		telescope.setup({
			defaults = {
				prompt_prefix = "󰍉 ",
				selection_caret = "▶️ ",
				entry_prefix = " ",
				multi_icon = " ",
				mappings = {
					i = {
						["<c-down>"] = actions.cycle_history_next,
						["<c-up>"] = actions.cycle_history_prev,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					themes.get_dropdown(),
				},
				["file_browser"] = {
					path = "%:p:h",
					cwd_to_path = true,
					layout_strategy = "center",
					layout_config = { height = 0.65, width = 0.70 },
					previewer = false,
					hijack_netrw = true,
					hidden = {
						file_browser = true,
						folder_browser = true,
					},
				},
			},
		})

		-- [[ Telescope extensions ]]
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "file_browser")

		-- [[ Custom Telescope keymaps ]]
		-- `:h telescope.builtin`

		-- [[ File related keymaps ]]
		-- Find files:
		-- search files in the current working directory
		map("n", "<leader>tsf", function()
			builtin.find_files({
				hidden = true,
				layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 },
			})
		end, { desc = "[S]earch [F]iles" })

		-- search files in the buffer's current working directory
		map("n", "<leader>tsc", function()
			builtin.find_files({
				cwd = utils.buffer_dir(),
				hidden = true,
				layout_config = { width = 0.95, height = 0.95, preview_width = 0.6 },
			})
		end, { desc = "[S]earch [F]iles (current buffer)" })

		-- Old files:
		-- search recently open files `:h telescope.builtin.oldfiles`
		map("n", "<leader>tof", function()
			builtin.oldfiles({
				previewer = false,
				layout_strategy = "vertical",
				layout_config = { prompt_position = "top", width = 0.9 },
			})
		end, { desc = "[S]earch [O]ld Files" })

		-- Live grep:
		-- `h: telescope.builtin.live_grep`
		map("n", "<leader>tsg", function()
			builtin.live_grep({
				layout_strategy = "vertical",
				layout_config = { prompt_position = "bottom", width = 0.95, height = 0.95 },
			})
		end, { desc = "[S]earch by [G]rep" })

		-- Search word under cursor:
		-- `:h telescope.builtin.grep_string`
		map("n", "<leader>tsw", function()
			builtin.grep_string({
				layout_strategy = "vertical",
				layout_config = { prompt_position = "bottom", width = 0.95, height = 0.95 },
			})
		end, { desc = "[S]earch current [W]ord" })

		-- Fuzzy search in buffer:
		-- `:h telescope.builtin.current_buffer_fuzzy_find`
		map("n", "<leader>t/", function()
			builtin.current_buffer_fuzzy_find({
				layout_strategy = "center",
				windblend = 10,
				previewer = false,
				layout_config = { width = 0.6, height = 0.55 },
			})
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Open telescope file browser:
		-- `:h telescope-file-browser`
		map("n", "<leader>tb", function()
			telescope.extensions.file_browser.file_browser({
				cwd = vim.fn.expand("%:p:h"),
				layout_strategy = "horizontal",
				layout_config = {
					height = 0.90,
					prompt_position = "top",
					width = 0.90,
					preview_width = 0.65,
				},
				grouped = true,
				depth = 2,
				hidden = {
					file_browser = true,
					folder_browser = true,
				},
				respect_gitignore = false,
				previewer = true,
			})
		end, { desc = "File [B]rowser" })

		-- [[ Neovim related keymaps ]]
		-- Open quickfix:
		-- `:h telescope.builtin.quickfix`
		map("n", "<leader>tq", function()
			builtin.quickfix({
				layout_strategy = "center",
				prompt_position = "bottom",
				layout_config = { width = 0.75 },
				previewer = false,
			})
		end, { desc = "[Q]uiqfix" })

		-- Search open existing buffers:
		-- `:h telescope.builtin.buffers`
		map("n", "<leader>t<leader>", function()
			builtin.buffers({
				previewer = false,
				layout_strategy = "center",
				layout_config = { height = 0.5, width = 0.7 },
			})
		end, { desc = "[S]earch Open [B]uffers" })

		-- Search help tags:
		map("n", "<leader>tht", function()
			builtin.help_tags({
				layout_strategy = "bottom_pane",
				layout_config = { prompt_position = "bottom", height = 0.8, preview_width = 0.7 },
			})
		end, { desc = "[H]elp [T]ags" })

		-- Search Neovim config files:
		map("n", "<leader>tsn", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
				border = false,
				previewer = false,
				layout_strategy = "center",
				layout_config = { height = 0.7 },
			})
		end, { desc = "[S]earch [N]eovim Files" })

		-- Search keymaps:
		-- `:h telescope.builtin.keymaps`
		map("n", "<leader>tsk", function()
			builtin.keymaps({ layout_strategy = "center", layout_config = { width = 0.7, height = 0.6 } })
		end, { desc = "[S]earch [K]eymaps" })

		-- [[ LSP related keymaps ]]

		map("n", "<leader>tgd", function()
			builtin.lsp_definitions({ layout_config = { width = 0.95, height = 0.95 } })
		end, { desc = "LSP [D]efinitions" })

		map("n", "<leader>tgr", builtin.lsp_references, { desc = "LSP [R]eferences" })

		map("n", "<leader>tgI", builtin.lsp_implementations, { desc = "LSP [I]mplementation" })

		map("n", "<leader>tD", builtin.lsp_type_definitions, { desc = "LSP Type [D]efinition" })

		map("n", "<leader>tds", function()
			builtin.lsp_document_symbols({ layout_config = { width = 0.95, height = 0.95 } })
		end, { desc = "LSP [D]ocument [S]ymbols" })

		map("n", "<leader>tws", function()
			builtin.lsp_dynamic_workspace_symbols({ layout_config = { width = 0.95, height = 0.95 } })
		end, { desc = "LSP [W]orkspace [S]ymbols" })
	end,
}
