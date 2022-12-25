require 'config_module' .register(...)

local M = {}

M.filetype = 'c'

---@class Preset
---@field flags string

---@type table<string, Preset>
M.presets = {
    ['&Release'] = {
        flags = '-O2'
    },
    ['&Debug'] = {
        flags = '-g'
    },
}

M.mode_choosing_strings = ''
M.preset_list = {}

for k, v in pairs(M.presets) do
    if M.mode_choosing_strings ~= '' then
        M.mode_choosing_strings = M.mode_choosing_strings .. '\n'
    end
    M.mode_choosing_strings = M.mode_choosing_strings .. k
    table.insert(M.preset_list, v)
end

---@param preset Preset
---@return string
function M.preset_to_build_string(preset)
    local flags = preset.flags
    local shared_flags = '-pedantic -DLOCAL -Wshadow -Wconversion -Wall -Wextra -std=c11 -lm'
    local file_info = M.get_file_info()
    return string.format(
        'mkdir -p "%s" && gcc %s %s "%%:p" -o "%s"',
        file_info.build_dirname, shared_flags, flags, file_info.exe_file
    )
end

function M.get_file_info(filename)
    if filename == nil then
        filename = vim.fn.expand("%:p")
    end
    local dirname = vim.fs.dirname(filename)
    local build_dirname = dirname .. '/' .. vim.b.c_out_dir
    local filename_no_ext = string.gsub(vim.fs.basename(filename), '^(.*)%.(.*)$', '%1')
    local exe_file = build_dirname .. '/' .. filename_no_ext
    return {
        dirname = dirname,
        build_dirname = build_dirname,
        filename_no_ext = filename_no_ext,
        exe_file = exe_file
    }
end

function M.gen_makeprg()
    local choice = vim.fn.confirm('Choose build mode:', M.mode_choosing_strings)
    if choice == 0 then
        print('No preset is chosen')
        return
    end
    local makeprg = M.preset_to_build_string(M.preset_list[choice])
    print(makeprg)
    return makeprg
end

function M.setup()
    vim.cmd.compiler 'gcc'
    local b = vim.b
    b.c_out_dir = 'build'
end

function M.run_single_file_command()
    return string.format('%s', M.get_file_info().exe_file)
end

require('single_file_runner').register_single_file_command(M)

return M
