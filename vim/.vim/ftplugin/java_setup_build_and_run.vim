compiler javac
set makeprg=javac\ -d\ .\ -cp\ \"./*.jar\"\ \"%:p\"
let b:run_single_file_command = "java %< Main"
