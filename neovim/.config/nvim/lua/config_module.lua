-- The module help hot reload neovim config in lua
-- without reloading the plugin modules.
-- 
-- Usage
-- ### Register config module:
-- Put the following line in the beginning of the file
--      require 'config_module'.register(...)
-- `...` will be extended to module name (and maybe the file name too)
-- 
-- ### Reload config module
-- Call the following vim command
-- `:ReloadConfig`

local M = {
    module_name = ...
}

---Normalize module name (by replacing `.` with `/`)
---@param mod_name string
---@return string result
function M.normalize_mod_name(mod_name)
    local result = string.gsub(mod_name, '%.', '/')
    return result
end

---@type table<string, boolean>
M.config_modules = {}

---@param modname string the module name
function M.register(modname)
    M.config_modules[M.normalize_mod_name(modname)] = true
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
    vim.cmd(string.format([[ 
        command! ReloadConfig lua require('%s').readload_config()
    ]], M.module_name))
end

M.setup_command()

return M

