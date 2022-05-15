" Very simple comment
" This is relatively short and easy to configuration, so there is no need for a plugin
" ====================
func! simple_comment#get_comment(filetype)
    " I could use a dictionary to store all of these, but meh, they are
    " lengthy, beside a lot of languages are C-like. 
    if index(['cpp', 'c', 'java', 'pascal', 'javascript', 'rust', 'kotlin', 'scss', 'antlr4'], a:filetype) != -1
        return ['//', '']
    elseif index(['vim'], a:filetype) != -1
        return ['"', '']
    elseif index(['lua', 'moon'], a:filetype) != -1
        return ['--', '']
    elseif index(['html', 'xml'], a:filetype) != -1
        return ["<!--", "-->"]
    elseif index(['tex'], a:filetype) != -1
        return ['%', '']
    elseif index(['pov', 'asm', 'nasm'], a:filetype) != -1
        return [';', '']
    else
        return ['#', '']  " well almost configuration file has this kind of commend
    endif
endfunc

func! simple_comment#toggle_comment()
    let cur_line = getline(line('.'))
    if !exists('b:comment_start')  
        let [b:comment_start, b:comment_stop] = simple_comment#get_comment(&filetype)
    endif
    let changed_line = substitute(cur_line, '^\(\s*\)' . b:comment_start . '\ \?\(.\{-}\)\ \?' . b:comment_stop . '\(.*\)', '\1\2\3', '')  
    if changed_line == cur_line 
        let changed_line = substitute(cur_line, '^\(\s*\)\(.*\)', '\1' . b:comment_start . ' \2' . b:comment_stop, '')  
    endif
    call setline(line('.'), changed_line)
endfunc
