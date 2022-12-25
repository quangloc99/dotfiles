require 'config_module'.register(...)

local M = {}

local keyset = vim.keymap.set

function M.general_keys()
    vim.g.mapleader = ','

    keyset('n', '<leader>w', ':w<cr>')

    -- Empty line indentation
    -- https://vim.fandom.com/wiki/Get_the_correct_indent_for_new_lines_despite_blank_lines
    -- There might be more, but these are frequently used so this is just a quick fix.
    keyset('i', '<CR>', '<CR>x<BS>')
    keyset('n', 'o', 'ox<BS>')
    keyset('n', 'O', 'Ox<BS>')

    keyset('n', '<C-H>', '<C-W>h')
    keyset('n', '<C-J>', '<C-W>j')
    keyset('n', '<C-K>', '<C-W>k')
    keyset('n', '<C-L>', '<C-W>l')
end

function M.formatter_keybind()
    local clangformat_group = vim.api.nvim_create_augroup('clangformat', { clear = true })
    local prettier_group = vim.api.nvim_create_augroup('prettier', { clear = true })

    -- use a custom function because clang-format.py accept the local variable from vim,
    -- and not lua.
    vim.cmd [[
    function! FormatFile()
        let l:lines="all"
        py3f ~/.vim/clang-format.py
    endfunction
    ]]

    vim.api.nvim_create_autocmd('BufEnter', {
        pattern = { '*.cpp', '*.c' },
        group = clangformat_group,
        callback = function()
            keyset('n', '<leader>fm', function() vim.fn.FormatFile() end)
        end
    })

    vim.api.nvim_create_autocmd('BufEnter', {
        pattern = { '*.js', '*.ts' },
        group = prettier_group,
        callback = function()
            keyset('n', '<leader>fm', ':!yarn prettier --write %:p<cr>')
        end
    })
end

function M.file_explorer_keybind()
    keyset('n', '<leader>nn', '<cmd>CHADopen --always-focus<cr>')
end

function M.Coc_keybind()
    local function show_documentation()
        if vim.fn.CocAction('hasProvider', 'hover') then
            vim.fn.CocActionAsync('doHover')
        else
            vim.fn.feedkeys('h', 'in')
        end
    end

    keyset('n', '<c-space>', 'coc#refresh()', { silent = true, expr = true })
    keyset('n', '<leader>h', show_documentation, { silent = true })

    keyset('n', 'gd', '<Plug>(coc-definition)', { silent = true })
    keyset('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
    keyset('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
    keyset('n', 'gr', '<Plug>(coc-references)', { silent = true })

    -- Rename. Get the impression of the F2 key
    keyset('n', '<leader>2', '<Plug>(coc-rename)', { silent = true })
end

function M.setup_single_file_runner()
    local single_file_runner = require('single_file_runner')
    keyset('n', '<leader>m', single_file_runner.do_make)
    keyset('n', '<leader>r', single_file_runner.execute_single_file)
end

M.general_keys()
M.formatter_keybind()
M.file_explorer_keybind()
-- M.Coc_keybind()
M.setup_single_file_runner()

return M
