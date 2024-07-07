return { -- Autoformat
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

		conform.formatters.biome = function()
			return {
				cwd = require("conform.util").root_file({ "biome.json" }),
				require_cwd = true,
			}
		end

		conform.formatters.deno_fmt = function()
			return {
				cwd = require("conform.util").root_file({ "deno.json", "deno.jsonc" }),
				require_cwd = true,
			}
		end

		conform.formatters.prettierd = function()
			return {
				cwd = require("conform.util").root_file({
					".prettierrc",
					".prettierrc.json",
					".prettierrc.mjs",
				}),
				require_cwd = true,
			}
		end

		conform.formatters.prettier = function()
			return {
				cwd = require("conform.util").root_file({
					".prettierrc",
					".prettierrc.json",
					".prettierrc.mjs",
				}),
				require_cwd = true,
			}
		end

		conform.setup({
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 2500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				json = { { "biome", "prettierd", "prettier", "deno_fmt" } },
				javascript = { { "biome", "prettierd", "prettier", "deno_fmt" } },
				typescript = { { "biome", "prettierd", "prettier", "deno_fmt" } },
				javascriptreact = { { "biome", "prettierd", "prettier", "deno_fmt" } },
				typescriptreact = { { "biome", "prettierd", "prettier", "deno_fmt" } },
				astro = { "prettier" },
				vue = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
			},
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
			conform.format({ async = true, lsp_fallback = true, range = range })
		end, { range = true })
	end,
}
