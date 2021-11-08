set nocompatible
set encoding=utf-8

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
colorscheme monochrome

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
set splitbelow splitright
set clipboard+=unnamedplus
set cursorline
set scroll=8
set wildmenu
" set cc=80 
set hlsearch
set foldmethod=marker

filetype indent plugin on
nnoremap <leader>w :w<cr>

" Empty line indentation
" https://vim.fandom.com/wiki/Get_the_correct_indent_for_new_lines_despite_blank_lines
" There might be more, but these are frequently used so this is just a quick fix.
" ==========================
inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>

" See ~/.vim/autoload/simple_comment.vim 
noremap <C-_> :call simple_comment#toggle_comment()<cr> 

" See ~/.vim/autoload/single_file_runner.vim
nnoremap <leader>m :call single_file_runner#do_make()<cr>
nnoremap <leader>r :exec single_file_runner#get_execute_command()<cr>
nnoremap <leader>cw :botright cw<cr>

" For makefile "all"
nnoremap <leader>p :!make<cr>

" NERD configuration
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>nn :NERDTreeMirror<cr>:NERDTreeFocus<cr>
nnoremap <leader>nf :NERDTreeFind<cr>
" Open the existing NERDTree on each new tab. 
" autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif 
" Exit Vim if NERDTree is the only window remaining in the only tab. 
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it. 
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" Debuging with GDB
" ===============================
packadd termdebug
nnoremap <leader>D :Termdebug %<<cr>
nnoremap <leader>b :Break<cr>
nnoremap <leader>B :Clear<cr>
nnoremap <F7> :Over<cr>
nnoremap <F8> :Step<cr>
nnoremap <S-F8> :Finish<cr>
nnoremap <F9> :Continue<cr>

" Other utilities
" ===============
" Setup for competitive programming
func! SetupCP()
    let cp_languages = ['cpp', 'c', 'java', 'pascal', 'javascript', 'python', 'kotlin', 'lua', 'rust']
    func! SetIO() abort closure
        unlet! b:single_file_input
        unlet! b:single_file_output
        unlet! b:single_file_error
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
        autocmd BufRead,BufNewFile * call SetIO()
    augroup END
endfunc

let g:syntastic_cpp_checkers = ['clang_check']
let g:syntastic_kotlin_checkers = ['kotlinc']
