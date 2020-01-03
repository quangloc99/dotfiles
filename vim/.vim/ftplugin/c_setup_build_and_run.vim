if &filetype != "c"
    " the thing is, this file is also called when editing "CPP" files.
    " I currently don't have any other solution for this.
    " So yeah, just exit the script.
    finish
endif
compiler gcc
let b:prev_build_choice = 1
func! Set_makeprg()
    let b:prev_build_choice = confirm('Choose build mode:', "&Release\n&Debug", b:prev_build_choice)
    if b:prev_build_choice == 2
        set makeprg=gcc\ -g\ -Wall\ -std=c99\ \"%:p\"\ -o\ %<
    else
        set makeprg=gcc\ -O2\ -Wall\ -std=c99\ \"%:p\"\ -o\ %<
    endif
endfunc

let b:set_makeprg = function('Set_makeprg')
let b:run_single_file_command = "./%<"
