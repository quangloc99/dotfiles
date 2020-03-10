compiler gcc
let b:prev_build_choice = 1
let b:cpp_std = "c++17"
let b:cpp_flag = "-DLOCAL -Wall -Wshadow -Wconversion -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -ffinite-math-only \"%:p\" -o %<"    
" let b:cpp_flag = "-DLOCAL \"%:p\" -o %<"   
func! Set_makeprg()
    let b:prev_build_choice = confirm('Choose build mode:', "&Release\n&Debug", b:prev_build_choice)

    if b:prev_build_choice == 2
        let option = "-g -DLOCAL_DEBUG"
    else
        let option = "-O2"
    endif
    let &makeprg = "g++ " . option . ' ' . b:cpp_flag . " -std=" . b:cpp_std
endfunc

let b:set_makeprg = function('Set_makeprg')
let b:run_single_file_command = "./%<"
