" Custom build and run setup
" ===========================
" Mostly I use vim for competitive programming as well as edit files like
" configurations file or do some testing. Having this made my things simpler.
"
" To use the functions in this file, you want to set :compiler, :set makeprg, ...
" See the functions for more detials.
" You you seeing this file, probably you are seeing my configuration files, in
" that case you can see ./vim/ftplugin/*_setup_build_and_run.vim files for
" examples.
"
" Notes:
"   For input file name, instead of % (file name relative to the current working path)
"   please use %:p (file name with absolute path).
"   The problem is when % is used, and you do something like the following:
"   - create file /a/main.cpp
"   - write and compile file /a/main.cpp
"   - come back to the root and create file /b/main.cpp
"   - write and compile file /b/main.cpp
"   From here, if there are errors in /b/main.cpp, Vim still see those errors, but file /a/main.cpp
"   will be opened rather than /b/main.cpp ??????
"   I guess it because when % is used, their names are the same, and vim only remember the first one.
"   So using the full file name is a quick solution.

" ============================================================================
" Different run commands to interact with different input and output file.
" The main purpose is mostly for competitive programming.

" Run the command set by makeprg. Also clear the shell's screen before each run.
" To use this command, simply :set makeprg before using it, or define the
" function b:set_makeprg() so that this function will call it.
" Inorder to get the error, you also want to set the :compiler
" To use it for each language, you should set those options with ftplugin
func! single_file_runner#do_make() abort
    if exists('b:gen_makeprg')
        let &makeprg = b:gen_makeprg()
    end
    let old_makeprg = &makeprg
    let msg = "echo " . &makeprg
    let &makeprg = "clear; " . msg . ";" . &makeprg
    if exists(":Neomake")
        Neomake!
    else 
        make
    endif
    let &makeprg = old_makeprg
endfunc

" Generate execute command. The generated command will have this form:
"
"   !clear; `b:run_single_file_command` [< `b:single_file_input`] [> `b:single_file_output`] [2> `b:single_file_error`]
"
" If `b:run_single_file_command` is not set, return an empty string.
"
" normally you want to use it with :exec command.
"
" The b:run_single_file_command is also recommeded to be set with ftplugin.
func! single_file_runner#get_execute_command() abort
    if !exists("b:run_single_file_command")
        return ""
    endif
    let command = "!clear; " . b:run_single_file_command . " "
    if exists("b:single_file_input")
        let command .= "< " . b:single_file_input . ' '
    endif

    if exists("b:single_file_output")
        let command .= "> " . b:single_file_output . ' '
    endif

    if exists("b:single_file_error")
        let command .= "2> " . b:single_file_error . ' '
    endif
    return command
endfunc
