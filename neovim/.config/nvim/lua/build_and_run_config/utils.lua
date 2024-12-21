local M = {}

function M.setup()
    vim.b.out_dir = 'build'
end

function M.get_file_info(filename)
    if filename == nil then
        filename = vim.fn.expand("%:p")
    end
    local dirname = vim.fs.dirname(filename)
    local build_dirname = dirname .. '/' .. vim.b.out_dir
    local filename_no_ext = string.gsub(vim.fs.basename(filename), '^(.*)%.(.*)$', '%1')
    local exe_file = build_dirname .. '/' .. filename_no_ext
    return {
        dirname = dirname,
        build_dirname = build_dirname,
        filename_no_ext = filename_no_ext,
        exe_file = exe_file
    }
end

return M
