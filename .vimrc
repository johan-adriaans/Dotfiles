
set nocompatible                    " choose no compatibility with legacy vi
filetype off                        " required by Vundle

set rtp+=~/.vim/bundle/vundle/      " Vundle
call vundle#rc()

" Vim package manager
Bundle 'gmarik/vundle'

" Needed by vundle
Bundle 'L9'

" Autocomplete with tab
Bundle 'ervandew/supertab'

" Smarty syntax
Bundle 'vim-scripts/smarty.vim'

" The PHP doc in vim doc format (shift-K in normal mode)

Bundle 'mudpile45/vim-phpdoc'
" support for LESS css files
Bundle 'groenewege/vim-less'

" Syntax check
Bundle 'scrooloose/syntastic'

"Bundle 'kingbin/vim-arduino'
"
" Bash ^n (like ^d in sublimetext)
Bundle 'terryma/vim-multiple-cursors'

" Nice looking toolbar at the bottom
Bundle 'bling/vim-airline'

" Find files in current directory
Bundle 'kien/ctrlp.vim'

" Track SVN/Git changes in the sidebar
Bundle 'mhinz/vim-signify'

" Find files
Bundle 'FuzzyFinder'

" Snippets
Bundle 'SirVer/ultisnips'

" Latest netrw
Bundle 'eiginn/netrw'

let g:snips_author = "Johan Adriaans <johan@izi-services.nl>"
let g:UltiSnipsEditSplit = "vertical"

" Fuzzy finder excludes
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr|svn)($|[/\\])'

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Let Ctrl-p follow symlinks
let g:ctrlp_follow_symlinks = 1

" Bundle 'tobyS/vmustache'
" Bundle 'SirVer/ultisnips'
" Bundle 'tobyS/pdv'
" let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
" nnoremap <buffer> <C-d> :call pdv#DocumentWithSnip()<CR>

filetype plugin indent on           " required by Vundle
syntax enable
set encoding=utf-8
set showcmd                         " display incomplete commands
set cursorline                      " Highlight current line
set lazyredraw                      " For responsive scrolling

"" Whitespace
set nowrap                          " don't wrap lines
set tabstop=2 shiftwidth=2          " a tab is two spaces (or set this to 4)
set expandtab                       " use spaces, not tabs (optional)
set backspace=indent,eol,start      " backspace through everything in insert mode

"SWAGG
set nopaste                         " setting good paste (past destroys supertab)
set number                          " setting line numbers

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " incremental searching
set ignorecase                      " searches are case insensitive...
set smartcase                       " ... unless they contain at least one capital letter
set tags=./tags;/                   " Autoload tags file

"" FuzzySearch keys
nnoremap <C-t> :FufTag<CR>
"nnoremap <C-p> :FufTaggedFile<CR>
nnoremap <C-f> :FufFileWithCurrentBufferDir<CR>

" Open tag definition in vertical split
"nnoremap <C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"" Color Scheme
colorscheme jellybeans

set laststatus=2                    " Always show the statusline
