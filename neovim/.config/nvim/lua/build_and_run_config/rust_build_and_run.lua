local utils = require('build_and_run_config/utils')

local M = {
    filetype='rust'
}

function M.setup()
    -- vim.cmd.compiler 'rust'
    
    vim.b.rust_out_dir = 'build'
    utils.setup()
end

local mode_prompt = '&Cargo\n&Single file'

function M.gen_makeprg()
    local choice = vim.fn.confirm('Choose build mode:', mode_prompt)
    if choice == 0 then
        print('No preset is chosen')
        return
    end

    if choice == 1 then
        return 'RUSTFLAGS="--cfg LOCAL" cargo build'
    else
        local filename = vim.fn.expand("%:p")
        local file_info = utils.get_file_info(filename)
        return string.format(
            'mkdir -p "%s" && rustc -O -D warnings -W dead-code -o "%s" "%s"',
            file_info.build_dirname, file_info.exe_file, filename
        )
    end
end

function M.run_single_file_command()
    local choice = vim.fn.confirm('Choose run mode:', mode_prompt)
    if choice == 0 then
        print('No preset is chosen')
        return
    end

    if choice == 1 then
        return 'RUSTFLAGS="--cfg LOCAL" cargo run'
    else
        local filename = vim.fn.expand("%:p")
        local file_info = utils.get_file_info(filename)
        return file_info.exe_file
    end
end

require('single_file_runner').register_single_file_command(M)

return M
