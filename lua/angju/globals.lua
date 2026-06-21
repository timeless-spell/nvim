local globals = {}

--- @alias origins
--- | 'gh' https://github.com
--- | 'cb' https://codeberg.org

--- @class ang.PluginSpec: vim.pack.Spec
--- @field origin? origins

--- @param spec ang.PluginSpec | string
function globals.pack_add(spec)
	if type (spec) == 'string' then
		vim.pack.add  { 'https://github.com/' .. spec }
		return
	elseif type (spec) == 'table' then
		spec.origin = spec.origin or 'gh'
		local plugin_spec = { version = spec.version, name = spec.name, data = spec.data }
		if spec.origin == 'cb' then
			plugin_spec.src = 'https://codeberg.org/' .. spec.src
		else
			plugin_spec.src = 'https://github.com/' .. spec.src
		end
		vim.pack.add  { plugin_spec }
		return
	end
end

--- @param key string
--- @param func string | function
--- @param desc? string
--- @param mode? string | string[]
function globals.map(key, func, desc, mode) vim.keymap.set (mode or 'n', key, func, { desc = desc }) end

--- @class ang.Keymap: vim.api.keyset.keymap
--- @field keys string
--- @field func function | string
--- @field mode? string | string[]

---@param keymap_list ang.Keymap[]
function globals.tbl_map(keymap_list)
	for _, value in ipairs (keymap_list) do
		vim.keymap.set (value.mode or 'n', value.keys, value.func, { desc = value.desc })
	end
end

--- @param name string
--- @param cmd table
--- @param cwd string
function globals.run_build(name, cmd, cwd)
	local result = vim.system (cmd, { cwd = cwd }):wait ()
	if result.code ~= 0 then
		local stderr = result.stderr or ''
		local stdout = result.stdout or ''
		local output = stderr ~= '' and stderr or stdout
		if output == '' then output = 'No output from build command.' end
		vim.notify (('Build failed for %s:\n%s'):format (name, output), vim.log.levels.ERROR)
	end
end

return globals
