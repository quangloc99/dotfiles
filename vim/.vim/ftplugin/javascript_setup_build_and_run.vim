if &filetype != "javascript"
    finish
endif
let b:run_single_file_command = "node %:p"
