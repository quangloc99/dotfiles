let b:run_single_file_command = "python3 '%:p'"
set makeprg=mypy\ --ignore-missing-imports\ '%:p'
