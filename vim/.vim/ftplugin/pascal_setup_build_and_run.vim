compiler! fpc 
set makeprg=fpc\ -vb\ -g\ -gl\ \"%:p\"\ -o%<
let b:run_single_file_command = "./%<"
