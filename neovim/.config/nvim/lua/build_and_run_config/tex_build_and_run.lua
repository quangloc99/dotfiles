require 'single_file_runner'.register_single_file_command {
    filetype = 'tex',
    gen_makeprg = function()
        local choice = vim.fn.confirm('Choose the engine', "&pdflatex\n&lualatex")
        if choice == 0 then
            return ''
        end

        if choice == 1 then
            return 'pdflatex -shell-escape -output-format=pdf "%:p" -halt-on-error'
        else
            return 'lualatex -shell-escape -output-format=pdf "%:p" -halt-on-error'
        end
    end,
    run_single_file_command = function()
        return 'xdg-open %%<.pdf &'
    end
}
