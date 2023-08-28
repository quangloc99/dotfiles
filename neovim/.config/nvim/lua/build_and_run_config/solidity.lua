require 'single_file_runner'.register_single_file_command {
    filetype = 'solidity',
    setup = function()
        vim.b.ale_linters = {
            'solhint'
        }
    end
}
