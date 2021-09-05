compiler gcc
let b:cpp_std = 'c++17'
let b:cpp_defines = '-DLOCAL'

func! CppFlagsSetSafety()
    let b:cpp_flag = '-Wall -Wshadow -Wconversion -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -ffinite-math-only -D_GLIBCXX_DEBUG'
endfunc

func! CppFlagsSetNonSafety()
    let b:cpp_flag = '-Wall -Wshadow -Wconversion'   
endfunc

call CppFlagsSetSafety()

let b:__cpp_prev_build_choice = 1
func! s:gen_makeprg()
    let choice = confirm('Choose build mode:', "&Release\n&Debug\n&Fast Relase", b:__cpp_prev_build_choice)
    if choice == 0
        return 'echo "Abort building"'
    endif

    let b:__cpp_prev_build_choice = choice
    let option = (['-O2', '-g -DLOCAL_DEBUG', '-O2'])[choice - 1]
    echo choice
    if choice == 3
        call CppFlagsSetNonSafety()
    else
        call CppFlagsSetSafety()
    endif

    return printf('g++ %s %s %s -std=%s "%%:p" -o %%<', option, b:cpp_defines, b:cpp_flag, b:cpp_std)
endfunc


let b:gen_makeprg = function('s:gen_makeprg')
let b:run_single_file_command = './%<'

