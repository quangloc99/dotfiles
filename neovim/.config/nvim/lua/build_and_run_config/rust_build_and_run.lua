local utils = require('build_and_run_config/utils')

local M = {
    filetype='rust'
}

function M.setup()
    -- vim.cmd.compiler 'rust'
    
    vim.b.rust_out_dir = 'build'
    utils.setup()
end

function M.gen_makeprg()
    local filename = vim.fn.expand("%:p")
    local file_info = utils.get_file_info(filename)
    return string.format(
        'mkdir -p "%s" && rustc -O -D warnings -W dead-code -o "%s" "%s"',
        file_info.build_dirname, file_info.exe_file, filename
    )
end

function M.run_single_file_command()
    return './%<'
end

require('single_file_runner').register_single_file_command(M)

return M
