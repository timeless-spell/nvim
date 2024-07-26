return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>ff",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	config = function()
		local conform = require("conform")

		conform.formatters = {
			deno_fmt = {
				cwd = require("conform.util").root_file({ "deno.json", "deno.jsonc" }),
				require_cwd = true,
			},
			prettierd = {
				cwd = require("conform.util").root_file({ ".prettierrc.json", ".prettierrc", ".prettierrc.js" }),
				require_cwd = true,
			},
			prettier = {
				cwd = require("conform.util").root_file({ ".prettierrc.json", ".prettierrc", ".prettierrc.js" }),
				require_cwd = true,
			},

			biome = {
				cwd = require("conform.util").root_file({ "biome.json" }),
				require_cwd = true,
			},
		}

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "deno_fmt", "biome", "prettierd", "prettier", stop_after_first = true },
				javascript = { "deno_fmt", "biome", "prettierd", "prettier", stop_after_first = true },
				json = { "deno_fmt", "prettierd", "prettier", "biome", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
				astro = { "prettierd", "prettier", stop_after_first = true },
			},
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = false, cpp = false }
				return {
					timeout_ms = 2500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			notify_on_error = false,
		})

		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			require("conform").format({ async = true, lsp_fallback = true, range = range })
		end, { range = true })
	end,
}
