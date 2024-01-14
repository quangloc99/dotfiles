local M = {}

local keyset = vim.keymap.set

function M.general_keys()
    vim.g.mapleader = ','

    keyset('n', '<leader>w', ':w<cr>')

    -- Empty line indentation
    -- https://vim.fandom.com/wiki/Get_the_correct_indent_for_new_lines_despite_blank_lines
    -- There might be more, but these are frequently used so this is just a quick fix.
    -- keyset('i', '<CR>', '<CR>x<BS>')
    -- keyset('n', 'o', 'ox<BS>')
    -- keyset('n', 'O', 'Ox<BS>')

    keyset('n', '<C-H>', '<C-W>h')
    keyset('n', '<C-J>', '<C-W>j')
    keyset('n', '<C-K>', '<C-W>k')
    keyset('n', '<C-L>', '<C-W>l')

    keyset('n', '<A-j>', 'gT')
    keyset('n', '<A-k>', 'gt')
end

function M.setup_single_file_runner()
    local single_file_runner = require('single_file_runner')
    keyset('n', '<leader>m', single_file_runner.do_make)
    keyset('n', '<leader>r', single_file_runner.execute_single_file)
end

M.general_keys()
M.setup_single_file_runner()

return M
