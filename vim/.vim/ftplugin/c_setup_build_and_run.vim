if &filetype != "c"
    " the thing is, this file is also called when editing "CPP" files.
    " I currently don't have any other solution for this.
    " So yeah, just exit the script.
    finish
endif

compiler gcc
let b:__c_prev_build_choice = 1
func! s:gen_makeprg()
    let choice = confirm('Choose build mode:', "&Release\n&Debug", b:__c_prev_build_choice)
    if choice == 0
        return
    endif
    let b:__c_prev_build_choice = choice
    let option = (['-O2', '-g'])[choice - 1]
    return printf('gcc %s -DLOCAL -Wshadow -Wconversion -Wall -Wextra -std=c99 "%%:p" -o %%<', option)
endfunc

let b:gen_makeprg = function('s:gen_makeprg')
let b:run_single_file_command = "./%<"
