
set nocompatible                    " choose no compatibility with legacy vi
filetype off                        " required by Vundle

set rtp+=~/.vim/bundle/vundle/      " Vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'L9'
Bundle 'ervandew/supertab'
Bundle 'mudpile45/vim-phpdoc'
Bundle 'lunaru/vim-less'
Bundle 'scrooloose/syntastic'

Bundle 'FuzzyFinder'
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr|svn)($|[/\\])'

Bundle 'tobyS/vmustache'
Bundle 'SirVer/ultisnips'
Bundle 'tobyS/pdv'
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <buffer> <C-d> :call pdv#DocumentWithSnip()<CR>

filetype plugin indent on           " required by Vundle
syntax enable
set encoding=utf-8
set showcmd                         " display incomplete commands
set cursorline                      " Highlight current line

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
set tags=tags                       " Autoload tags file

"" FuzzySearch keys
nnoremap <C-t> :FufTag<CR>
nnoremap <C-p> :FufTaggedFile<CR>
nnoremap <C-f> :FufFileWithCurrentBufferDir<CR>
nnoremap <C-b> :FufBuffer<CR>

" Open tag definition in vertical split
nnoremap <C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"" Color Scheme
colorscheme jellybeans

set laststatus=2                    " Always show the statusline
