func! s:gen_makeprg()
    return 'kotlinc "%:p" -include-runtime -d "%<.jar"'
endfunc

let b:gen_makeprg = function('s:gen_makeprg')
let b:run_single_file_command = "java -ea -jar %<.jar"
