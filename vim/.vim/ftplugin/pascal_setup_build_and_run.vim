compiler! fpc 
set makeprg=fpc\ -vb\ -O2\ \"%:p\"\ -o%<
let b:run_single_file_command = "./%<"
