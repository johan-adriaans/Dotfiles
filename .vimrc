set nocompatible                    " choose no compatibility with legacy vi
filetype off                        " required by Vundle

set rtp+=~/.vim/bundle/Vundle.vim/  " Vundle
call vundle#begin()

" Vundle plugin manager
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'

" The PHP doc in vim doc format (shift-K in normal mode)
Plugin 'mudpile45/vim-phpdoc'

" Automatic complete pop-up
Plugin 'othree/vim-autocomplpop'

" Automatic delimiter closing
"Plugin 'Raimondi/delimitMate'

Plugin 'pangloss/vim-javascript'

" Generate PHP Doc comments
Plugin 'sumpygump/php-documentor-vim'
inoremap <C-c> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-c> :call PhpDocSingle()<CR>
vnoremap <C-c> :call PhpDocRange()<CR>

let g:pdv_cfg_Package = "IZICMS"
let g:pdv_cfg_Version = "1.0"
let g:pdv_cfg_Author = "Johan Adriaans <johan@izi-services.nl>"
let g:pdv_cfg_Copyright = "Copyright (C) Shoppagina - All Rights Reserved"
let g:pdv_cfg_License = "Proprietary and confidential"
let g:pdv_cfg_ClassTags = ["package","author","copyright","license","version"]

" support for LESS css files
Plugin 'groenewege/vim-less'

" Nice looking toolbar at the bottom
Plugin 'bling/vim-airline'

" Enable powerline fonts
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1

" Find files in current directory
Plugin 'kien/ctrlp.vim'

" Force ctrlP to keep inital workingdir
let g:ctrlp_working_path_mode=0

" Let ctrlP search tags
let g:ctrlp_extensions = ['tag']

" Track SVN/Git changes in the sidebar
Plugin 'mhinz/vim-signify'

" Git fugitive
Plugin 'tpope/vim-fugitive'

" Tagbar for code overview
Plugin 'majutsushi/tagbar'

" Smarty indent
Plugin 'blueyed/smarty.vim'

" Syntax check
Plugin 'scrooloose/syntastic'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

" Debugging
"Plugin 'brookhong/DBGPavim'

" Arduino helper tools
"Plugin 'sudar/vim-arduino-syntax'

" Set font for gvim
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14

call vundle#end()                   " required by Vundle. No Plugin statements below this line
filetype plugin indent on
syntax enable

set encoding=utf-8
set showcmd                         " display incomplete commands
set cursorline                      " Highlight current line
set lazyredraw                      " For responsive scrolling

" Whitespace
set tabstop=2 shiftwidth=2          " a tab is two spaces (or set this to 4)
set expandtab                       " use spaces, not tabs (optional)
set backspace=indent,eol,start      " backspace through everything in insert mode
set textwidth=0
set formatoptions-=t
set foldmethod=manual
set shortmess=atI                   " Improve [Press ENTER to continue] prompt messages

" Map tab to ctrl-n
" imap <s-tab> <C-x><C-o>
" imap <tab> <C-n>

set wildmenu                        " Enable wildcard menu
set wildmode=list:longest
set title                           " Set window title for gvim etc

set scrolloff=4                     " Window scroll offset. T o keep context while scrolling
set number                          " setting line numbers
set splitright                      " Always open vertical splits to the right

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " incremental searching
set ignorecase                      " searches are case insensitive...
set smartcase                       " ... unless they contain at least one capital letter
set tags=./tags;/                   " Autoload tags file

"" Some sessions settings
set ssop-=options                   " do not store global and local values in a session
set ssop-=folds                     " do not store folds

set laststatus=2                    " Always show the statusline
set wrap                            " Enable line wrapping

if exists("&breakindent")
  set breakindent                   " Every wrapped line will continue visually indented (>7.4.338)
  set showbreak=\ \ ↪\              " Indentation character
  set linebreak                     " Don't break words
endif

" Omnicompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType smarty set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType less set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" format PHP
map <Leader>p mz:silent 1,$!phpcbf<CR> gg=G`zzz

" format JSON
map <Leader>j :%!python -m json.tool<CR>

"" format XML
map <Leader>x :silent 1,$!xmllint --format --recover - 2>/dev/null<CR>

" Toggle tag bar
map <Leader>t :TagbarToggle<CR>

" Remove trailing spaces
map <Leader>s :%s/\s\+$//g<CR>:%s/\t/  /g<CR>

" Edit vimrc
map <Leader>v :vs ~/.vimrc<CR>
map <Leader>V :source ~/.vimrc<CR>

"" Color Scheme
colorscheme jellybeans
highlight Normal ctermbg=none

"" Highlight unwanted spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"" Fix supposed memleak when matching too often
if version >= 702
    autocmd BufWinLeave * call clearmatches()
endif

"" No tabs2spaces for makefiles
autocmd FileType make call VanillaTabs()
function VanillaTabs()
  setlocal noexpandtab
  iunmap <tab>
endfunction

" if &term =~ '^screen'
"   " tmux will send xterm-style keys when its xterm-keys option is on
"   execute "set <xUp>=\e[1;*A"
"   execute "set <xDown>=\e[1;*B"
"   execute "set <xRight>=\e[1;*C"
"   execute "set <xLeft>=\e[1;*D"
"
"   " Handle tmux $TERM quirks in vim
"   if $TERM =~ '^screen-256color'
"     map <Esc>OH <Home>
"     map! <Esc>OH <Home>
"     map <Esc>OF <End>
"     map! <Esc>OF <End>
"   endif
" endif

" Enable grep searching with :grep findword
set grepprg=grep\ -nir\ $*\ *

" Enable matchit (Extendend % matching for html tags)
runtime macros/matchit.vim

" Make PHP indent cases in switch statements
let g:PHP_vintage_case_default_indent=1

" Map jj to Esc in normal mode
imap jj <Esc>

" Allow moving up/down like you expect in a wrapped line
nmap j gj
nmap k gk

if has("autocmd")
  " Have Vim jump to the last position when reopening a file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " Set PHP formatter
  autocmd FileType php set formatprg=phpcbf
endif

" Expand %%/ to current/file/working/dir when in Ex mode
cabbr <expr> %% expand('%:p:h')
