local M = {
    __is_config_module__ = true
}

function M.do_make()
    if type(vim.b.gen_makeprg) == 'function' then
        vim.opt.makeprg = vim.b.gen_makeprg()
    end
    if vim.opt.makeprg == '' then
        return
    end
    local old_makeprg = vim.opt.makeprg:get()
    vim.opt.makeprg = string.format('clear; echo \'%s\'; %s', old_makeprg, old_makeprg)
    if vim.fn.exists(':Neomake') ~= 0 then
        vim.cmd.Neomake { bang = true }
    else
        vim.cmd.make()
    end
    vim.opt.makeprg = old_makeprg
end

function M.get_single_file_execute_command()
    if type(vim.b.run_single_file_command) == 'nil' then
        return ''
    end
    local res = '!echo && '
    local b = vim.b
    if type(b.run_single_file_command) == 'function' then
        res = res .. vim.b.run_single_file_command()
    else
        res = res .. vim.b.run_single_file_command
    end
    if type(b.single_file_input) == 'string' then
        res = res .. ' < ' .. b.single_file_input
    end
    if type(b.single_file_output) == 'string' then
        res = res .. ' > ' .. b.single_file_output
    end
    if type(b.single_file_error) == 'string' then
        res = res .. ' 2> ' .. b.single_file_error
    end
    return res
end

function M.execute_single_file()
    local exec_command = M.get_single_file_execute_command()
    vim.cmd(exec_command)
end

M.run_single_file_group = vim.api.nvim_create_augroup('run_single_file', { clear = true })

function M.register_single_file_command(opts)
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { opts.filetype },
        group = M.run_single_file_group,
        callback = function()
            if type(opts.setup) == 'function' then
                opts.setup()
            end
            vim.b.gen_makeprg = opts.gen_makeprg
            vim.b.run_single_file_command = opts.run_single_file_command
        end
    })
end

return M
