set nocompatible                    " choose no compatibility with legacy vi
filetype off                        " required by Vundle

set rtp+=~/.vim/bundle/vundle/      " Vundle
call vundle#rc()

" Vim package manager
Bundle 'gmarik/vundle'

" Needed by vundle
Bundle 'L9'

" The PHP doc in vim doc format (shift-K in normal mode)
Bundle 'mudpile45/vim-phpdoc'

" support for LESS css files
Bundle 'groenewege/vim-less'

" Nice looking toolbar at the bottom
Bundle 'bling/vim-airline'

" Find files in current directory
Bundle 'kien/ctrlp.vim'

" Track SVN/Git changes in the sidebar
Bundle 'mhinz/vim-signify'

" Latest netrw
" Bundle 'eiginn/netrw'

" Smarty syntax
Bundle 'smarty.vim'

" Syntax check
" Bundle 'scrooloose/syntastic'

" Arduino helper tools
Bundle 'kingbin/vim-arduino'

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Force ctrlP to keep inital workingdir
let g:ctrlp_working_path_mode=0

" Let ctrlP search tags
let g:ctrlp_extensions = ['tag']

filetype plugin indent on
syntax enable

set encoding=utf-8
set showcmd                         " display incomplete commands
set cursorline                      " Highlight current line
set lazyredraw                      " For responsive scrolling

"" Whitespace
set tabstop=2 shiftwidth=2          " a tab is two spaces (or set this to 4)
set expandtab                       " use spaces, not tabs (optional)
set backspace=indent,eol,start      " backspace through everything in insert mode
set textwidth=0
set formatoptions-=t
set foldmethod=manual

set number                          " setting line numbers
set splitright                      " Always open vertical splits to the right

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " incremental searching
set ignorecase                      " searches are case insensitive...
set smartcase                       " ... unless they contain at least one capital letter
set tags=./tags;/                   " Autoload tags file

"" Some sessions settings
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

"" Color Scheme
colorscheme jellybeans

set laststatus=2                    " Always show the statusline
set wrap                            " Enable line wrapping
set breakindent                     " Every wrapped line will continue visually indented (>7.4.338)
set showbreak=\ \ ↪\                " Indentation character
set linebreak                       " Don't break words

" Map tab to ctrl-n
imap <tab> <c-n>

" format JSON
map <Leader>j :%!python -m json.tool<CR>

if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"

  " Handle tmux $TERM quirks in vim
  if $TERM =~ '^screen-256color'
    map <Esc>OH <Home>
    map! <Esc>OH <Home>
    map <Esc>OF <End>
    map! <Esc>OF <End>
  endif
endif

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Expand %%/ to current/file/working/dir when in Ex mode
cabbr <expr> %% expand('%:p:h')

" Fix all XML files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

if has("autocmd")
  let php_pipeline  = "perl -i -pe 's/ elseif / else if /g' --"
  let php_pipeline .= " | astyle --indent-cases --pad-paren-in --pad-header --unpad-paren --keep-one-line-blocks --convert-tabs --indent=spaces=2"
  let php_pipeline .= " | perl -i -pe 's/^([\s]+)([A-z]+\s?function .*){/$1$2\\n$1\\{/g' --"
  autocmd FileType php let &formatprg=php_pipeline
endif
