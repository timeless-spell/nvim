Angju.later(function ()
	vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

	local function js_format (bufnr)
		local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
		if deno_root then
			return { 'deno_fmt' }
		else
			return { 'biome' }
		end
	end

	require('conform').setup {
		formatters_by_ft = {
			lua = { 'stylua' },
			html = { 'biome' },
			css = { 'biome' },
			javascript = js_format,
			typescript = js_format,
			json = { 'biome' },
			toml = { 'taplo' },
		},
		format_after_save = {
			lsp_format = 'fallback',
			async = true,
			timeout_ms = 500,
		},
	}
end)
