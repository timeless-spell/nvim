local Angju = {}

_G.Angju = Angju

---@param keys string
---@param func string | function
---@param desc string
---@param mode? string | string[]
Angju.map = function (keys, func, desc, mode)
    mode = mode or "n"

    vim.keymap.set (mode, keys, func, { desc = desc })
end

---@param keys string
---@param func string | function
---@param desc string
---@param buf number
Angju.bmap = function (keys, func, desc, buf)
    vim.keymap.set ("n", keys, func, { desc = desc, buffer = buf })
end

---@param dir string
---@param tbl string[]
Angju.dynamic_require = function (dir, tbl)
    for _, value in ipairs (tbl) do
        pcall (require, dir .. "." .. value)
    end
end
