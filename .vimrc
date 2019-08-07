call plug#begin('~/.vim/plug-bundles')

" ====================== COC =========================
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-html', 'coc-phpls', 'coc-css', 'coc-sql', 'coc-json', 'coc-yaml', 'coc-marketplace', 'coc-tsserver', 'coc-tabnine']

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" ===================== PHPDOC =======================
Plug 'mudpile45/vim-phpdoc'       " shift-K in normal mode

" ================ PHP doc comments ==================
"Plugin 'sumpygump/php-documentor-vim'
"inoremap <C-c> <ESC>:call PhpDocSingle()<CR>i
"nnoremap <C-c> :call PhpDocSingle()<CR>
"vnoremap <C-c> :call PhpDocRange()<CR>
"let g:pdv_cfg_Package = "IZICMS"
"let g:pdv_cfg_Version = "1.0"
"let g:pdv_cfg_Author = "Johan Adriaans <johan@izi-services.nl>"
"let g:pdv_cfg_Copyright = "Copyright (C) Shoppagina - All Rights Reserved"
"let g:pdv_cfg_License = "Proprietary and confidential"
"let g:pdv_cfg_ClassTags = ["package","author","copyright","license","version"]

" ==================== LESS ==========================
"Plugin 'groenewege/vim-less'

" ================== Airline =========================
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1

" ========= Find files in current directory ==========
Plug 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode=0     " Force ctrlP to keep inital workingdir
let g:ctrlp_extensions = ['tag']    " Let ctrlP search tags
map <c-p> <ESC>:CtrlPMRU<CR>

" ====== Track SVN/Git changes in the sidebar ========
Plug 'mhinz/vim-signify'

" =============== Git fugitive =======================
Plug 'tpope/vim-fugitive'

" ================== Tagbar ==========================
"Plugin 'majutsushi/tagbar'
"Plugin 'vim-php/tagbar-phpctags.vim'

" =============== Smarty indent ======================
"Plug 'blueyed/smarty.vim'

" ========== Go development and code intel ===========
"Plugin 'fatih/vim-go'
"Plugin 'nsf/gocode', {'rtp': 'vim/'}

" ============ Gruvbox color scheme ==================
Plug 'morhetz/gruvbox'

" ======== Python style and indentation===============
"Plug 'nvie/vim-flake8'
"Plug 'vim-scripts/indentpython.vim'

" ==================== Arduino =======================
"Plugin 'sudar/vim-arduino-syntax'

" Initialize plugin system
call plug#end()

set nocompatible                    " choose no compatibility with legacy vi
set hidden                          " if hidden is not set, TextEdit might fail.
set cmdheight=2                     " Better display for messages
set updatetime=300                  " You will have bad experience for diagnostic
                                    " messages when it's default 4000.

" Set font for gvim
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14

set encoding=utf-8
set showcmd                         " display incomplete commands
set lazyredraw                      " For responsive scrolling

"" Spaces and wraps
set tabstop=2 shiftwidth=2          " a tab is two spaces
set expandtab                       " use spaces, not tabs (optional)
set backspace=indent,eol,start      " backspace through everything in insert mode
set textwidth=0
set formatoptions-=t
set foldmethod=manual
"set shortmess=atI                   " Improve [Press ENTER to continue] prompt messages
set shortmess+=c
set wrap                            " Enable line wrapping

set wildmenu                        " Enable wildcard menu
set wildmode=list:longest
set title                           " Set window title for gvim etc
set scrolloff=4                     " Window scroll offset. T o keep context while scrolling
set number                          " setting line numbers
set splitright                      " Always open vertical splits to the right
set splitbelow                      " Always open horizontal splits at the bottom

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " incremental searching
"set ignorecase                      " searches are case insensitive...
"set infercase                       " Infer match case based on keyword
set smartcase                       " ... unless they contain at least one capital letter
set tags=./tags;/                   " Autoload tags file
set laststatus=2                    " Always show the statusline

"" Some sessions settings
set ssop-=options                   " do not store global and local values in a session
set ssop-=folds                     " do not store folds

" Speed up syntax highlighting for big files
set nocursorcolumn
set nocursorline

syntax sync minlines=256
set synmaxcol=300
autocmd FileType html syntax sync fromstart

"" Pretty wrap indent
if exists("&breakindent")
  set breakindent                   " Every wrapped line will continue visually indented (>7.4.338)
  set showbreak=\ \ ↪\              " Indentation character
  set linebreak                     " Don't break words
endif

" Map tab to code completion and to up/down when wildmenu is visible
inoremap <expr> <Tab> pumvisible() ? "\<down>" : "\<C-n>"
inoremap <expr> <S-Tab> pumvisible() ? "\<up>" : "\<C-x>"

" Complete popup
set completeopt-=preview
set completeopt+=menu,menuone
set shortmess+=c

" Autoclose preview after complete
autocmd CompleteDone * pclose

" Omnicompletion
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType smarty setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType less setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType go setlocal omnifunc=gocomplete#Complete

" Python PEP 8
autocmd FileType python
            \ setlocal tabstop=4 |
            \ setlocal softtabstop=4 |
            \ setlocal shiftwidth=4 |
            \ setlocal textwidth=79 |
            \ setlocal expandtab |
            \ setlocal autoindent |
            \ setlocal fileformat=unix

" Set PHP formatter
autocmd FileType php set formatprg=phpcbf

"" Session saving
map <silent> <F5> :mks! ~/.vim/session.vim<CR>
map <silent> <F9> :source ~/.vim/session.vim<CR>

"" format PHP
map <Leader>p mz:silent 1,$!phpcbf --standard=IZI -q -<CR> gg=G`zzz

"" format JSON
map <Leader>j :%!python -m json.tool<CR>

"" format HTML
map <Leader>h :silent 1,$!tidy -i -asxhtml -omit -q -wrap 0 -file /dev/null \| grep -v 'meta name="generator" content="HTML Tidy'<CR>

"" format XML
map <Leader>x :silent 1,$!xmllint --format --recover - 2>/dev/null<CR>

"" Toggle tag bar
map <Leader>t :TagbarToggle<CR>

"" Remove trailing spaces and replace tabs
map <silent> <Leader>s ms:%s/\s\+$//g <bar> :%s/\t/  /g<CR>`s

"" Open file with path absolute to project root enclosed in " (Yeah, a bit
"" specific, I know. Let's see if I use it and then improve ;)
map <Leader>f T"lvt"gf

"" Edit vimrc
map <Leader>v :vs ~/.vimrc<CR>
map <Leader>V :source ~/.vimrc<CR>

"" Map - (minus) to explore. Minus in explore is one level up, this feels natural
map - :Explore<CR>

"" Colorscheme
silent! colorscheme gruvbox
set background=dark
"highlight Normal ctermbg=none

" Have Vim jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

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

"" Enable grep searching with :grep findword
set grepprg=grep\ -nir\ $*\ *

"" Enable matchit (Extendend % matching for html tags)
runtime macros/matchit.vim

"" Map jj to Esc in normal mode
imap jj <Esc>

"" Allow moving up/down like you expect in a wrapped line
nmap j gj
nmap k gk

" Expand %%/ to current/file/working/dir when in Ex mode
cabbr <expr> %% expand('%:p:h')
