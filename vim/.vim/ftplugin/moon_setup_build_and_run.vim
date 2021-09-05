function s:gen_makeprg()
    return "moonc '%:p'"
endfunc
let b:gen_makeprg = function('s:gen_makeprg')
let b:run_single_file_command = "lua5.3 '%<.lua'"
