call pathogen#runtime_append_all_bundles()  " adding pathogen to vimrc
call pathogen#helptags()

set nocompatible                    " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                         " display incomplete commands
filetype plugin indent on           " load file type plugins + indentation

"" Whitespace
set nowrap                          " don't wrap lines
set tabstop=2 shiftwidth=2          " a tab is two spaces (or set this to 4)
set expandtab                       " use spaces, not tabs (optional)
set backspace=indent,eol,start      " backspace through everything in insert mode

"SWAGG
set nopaste                           " setting good paste (past destroys supertab)
set number                  " setting line numbers

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " incremental searching
set ignorecase                      " searches are case insensitive...
set smartcase                       " ... unless they contain at least one capital letter

"" Mappings
nmap <F8> :BufExplorer<CR>         " mapping f8 to TagbarToggle
nmap <F2> :NERDTreeToggle<CR>       " mapping f2 to NERDTreeToggle
inoremap jj <Esc>                   "<Esc> to jj

"" Mapping 
let mapleader = ","                 " setting leader to , 

"" Color Scheme
colorscheme jellybeans

set laststatus=2                    " Always show the statusline

" Enable fancy mode 
let g:Powerline_symbols = 'fancy'   " Powerline

" PHP autocoplete
filetype plugin on
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Automatically load project ctags
set tags=./tags;/

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

au BufNewFile,BufRead *.less set filetype=less
