set nocompatible

if v:version < 800
    execute pathogen#infect('pack/{}/start/{}')
    echom "pathogen loaded"
else
    echom "use default vim package manager"
endif

" Personal local settings
" =======================
set background=dark
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
colorscheme PaperColor

let mapleader = ","
let g:mapleader = ","

" Overall settings
" ================
syntax on
filetype plugin indent on
set bs=2 tabstop=4 softtabstop=4 shiftwidth=4 expandtab
hi Normal guibg=NONE ctermbg=NONE
hi! NonText ctermbg=NONE guibg=NONE
set aw 
set autoindent cindent
set nowrap textwidth=0
set nu ruler showcmd
set incsearch ignorecase smartcase
set scrolloff=5
set splitright splitbelow
set clipboard=unnamed
set cursorline
set scroll=8
set wildmenu
filetype indent plugin on
nnoremap <leader>w :w<cr>

" See ~/.vim/autoload/simple_comment.vim 
noremap <C-_> :call simple_comment#toggle_comment()<cr> 

" See ~/.vim/autoload/single_file_runner.vim
nnoremap <leader>m :call single_file_runner#do_make()<cr>
nnoremap <leader>r :exec single_file_runner#get_execute_command()<cr>

" Debuging with GDB
" ===============================
nnoremap <leader>D :Termdebug %<<cr>
nnoremap <leader>b :Break<cr>
nnoremap <leader>B :Clear<cr>
nnoremap <F7> :Over<cr>
nnoremap <F8> :Step<cr>
nnoremap <S-F8> :Finish<cr>
nnoremap <F9> :Continue<cr>

" Run some custom script in some cases
" ====================================
let scriptsHome = './'
nnoremap <leader>1 :exe '!' . scriptsHome . 'compile'<cr>
nnoremap <leader>2 :exe '!' . scriptsHome . 'run'<cr>
nnoremap <leader>3 :exe '!' . scriptsHome . 'test'<cr>

" Other utilities
" ===============
" Setup for competitive programming
func! SetupCP()
    let cp_languages = ['cpp', 'c', 'java', 'pascal', 'javascript', 'python', 'kotlin', 'lua']
    func! SetIO() abort closure
        if index(cp_languages, &filetype) == -1
            return
        endif
        if confirm("Setup IO for cp???", "&Yes\n&No", 1) != 1
            return 
        endif
        let b:single_file_input = "main.inp"
        let b:single_file_output = "main.out"
        let b:single_file_error = ".log"
        echom "All set"
    endfunc

    augroup CPSetup
        au!
        autocmd BufRead * call SetIO()
    augroup END
endfunc
