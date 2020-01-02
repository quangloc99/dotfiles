compiler php
set makeprg=php\ -lq\ %:p
let b:run_single_file_command = "php -f '%:p'"
