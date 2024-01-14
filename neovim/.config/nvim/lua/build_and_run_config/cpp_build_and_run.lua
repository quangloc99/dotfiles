local M = {}

M.presets = {
    ['&Release'] = {
        opt_mode = 2,
        with_safety_flags = false,
        with_debug_flags = false
    },
    ['&Debug'] = {
        opt_mode = 2,
        with_safety_flags = true,
        with_debug_flags = true
    },
    ['&Fast Release'] = {
        opt_mode = 0,
        with_safety_flags = false,
        with_debug_flags = false,
    },
    ['Fast D&ebug'] = {
        opt_mode = 0,
        with_debug_flags = true,
        with_safety_flags = false
    }
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

function M.preset_to_build_string(preset)
    local flags = vim.b.cpp_normal_flags
    if preset.with_safety_flags then
        flags = vim.b.cpp_safety_flags
    end
    local debug_flags = ''
    if preset.with_debug_flags then
        debug_flags = vim.b.cpp_debug_flags
    end
    local file_info = M.get_file_info()
    return string.format(
        'mkdir -p "%s" && g++ %s -std=%s -O%s %s %s "%%:p" -o "%s"',
        file_info.build_dirname, vim.b.cpp_defines, vim.b.cpp_std,
        preset.opt_mode, flags, debug_flags, file_info.exe_file
    )
end

function M.get_file_info(filename)
    if filename == nil then
        filename = vim.fn.expand("%:p")
    end
    local dirname = vim.fs.dirname(filename)
    local build_dirname = dirname .. '/' .. vim.b.cpp_out_dir
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
    return M.preset_to_build_string(M.preset_list[choice])
end

function M.setup()
    vim.cmd.compiler 'gcc'
    local b = vim.b

    b.cpp_std = 'c++20'
    b.cpp_defines = '-DLOCAL'
    b.cpp_safety_flags = '-Wall -Wshadow -Wconversion -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -ffinite-math-only -D_GLIBCXX_DEBUG'
    b.cpp_normal_flags = '-Wall -Wshadow -Wconversion'
    b.cpp_debug_flags = '-DLOCAL_DEBUG -g'
    b.cpp_out_dir = 'build'
end

function M.run_single_file_command()
    return string.format('%s', M.get_file_info().exe_file)
end

M.filetype = 'cpp'

require('single_file_runner').register_single_file_command(M)

return M
