compiler rustc

" TODO add warning options
let b:rust_predefines = "--cfg LOCAL"
let b:__rust_prev_build_choice = 1
func! s:gen_makeprg()
    let choice = confirm('Choose build mode', "&Release\n&Debug", b:__rust_prev_build_choice)
    if choice == 0
        echo "Abort building"
        return ""
    endif

    let b:__rust_prev_build_choice = choice
    let option = (["-O", "-g --cfg LOCAL_DEBUG"])[choice - 1]

    return printf('rustc %s %s "%%:p" -o %%<', b:rust_predefines, option)
endfunc

let b:gen_makeprg = function('s:gen_makeprg')
let b:run_single_file_command = 'RUST_BACKTRACE=1 ./%<'
