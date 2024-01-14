local M = {
    filetype='pascal'
}

function M.setup()
    vim.cmd.compiler 'fpc'
end

function M.gen_makeprg()
    return 'fpc -vb -g -gl -So "%:p" -o%< -O2'
end

function M.run_single_file_command()
    return './%<'
end

require('single_file_runner').register_single_file_command(M)

return M
