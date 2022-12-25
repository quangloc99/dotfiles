local M = {}

---Normalize module name (by replacing `.` with `/`)
---@param mod_name string
---@return string result
function M.normalize_mod_name(mod_name)
    local result = string.gsub(mod_name, '%.', '/')
    return result
end

---@type table<string, boolean>
M.config_modules = {}

local old_require = require
function M.require(modname)
    local res = old_require(modname)
    if type(res) == 'table' and res.__is_config_module__ then
        M.config_modules[M.normalize_mod_name(modname)] = true
    end
    return res
end

function M.uncache_configs()
    for key, _ in pairs(M.config_modules) do
        package.loaded[key] = nil
        print(string.format('uncached module %s', key))
    end
end

function M.readload_config()
    M.uncache_configs()
    vim.cmd.luafile '~/.config/nvim/init.lua'
end

function M.setup_command()
    vim.cmd[[ 
        command! ReloadConfig lua require('require_config').readload_config()
    ]]
end

M.setup_command()

require = M.require

return M
