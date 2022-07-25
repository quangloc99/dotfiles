" This file will run for all files with extension .tex, which is not only
" plaintex, but also pdftex, luatex, ...

let b:plaintex_pdfviewer = 'evince'
let b:__plaintex_prev_choice = 1
function! s:gen_makeprg()
    let choice = confirm('Choose the engine', "&pdflatex\n&lualatex", b:__plaintex_prev_choice)
    if choice == 0
        return ""
    endif

    let b:__plaintex_prev_choice = choice
    if choice == 1
        return 'pdflatex -shell-escape -output-format=pdf "%:p" -halt-on-error'
    else
        return 'lualatex -shell-escape -output-format=pdf "%:p" -halt-on-error'
    endif

endfunc

let b:gen_makeprg = function('s:gen_makeprg')
let b:run_single_file_command = printf('%s %%<.pdf &', b:plaintex_pdfviewer)
