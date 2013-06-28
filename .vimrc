
set nocompatible                    " choose no compatibility with legacy vi
filetype off                        " required by Vundle

set rtp+=~/.vim/bundle/vundle/      " Vundle
call vundle#rc()                    

Bundle 'gmarik/vundle'

filetype plugin indent on           " required by Vundle

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
set nopaste                         " setting good paste (past destroys supertab)
set number                          " setting line numbers

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " incremental searching
set ignorecase                      " searches are case insensitive...
set smartcase                       " ... unless they contain at least one capital letter

"" Color Scheme
colorscheme jellybeans

set laststatus=2                    " Always show the statusline
