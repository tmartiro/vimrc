" set relativenumber
set nocompatible              " be iMproved, required
set hlsearch
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set hidden
filetype off                  " required



" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Solarized themes
Plugin 'altercation/vim-colors-solarized'
" Plugin 'wookiehangover/jshint.vim'
Plugin 'majutsushi/tagbar'
" Plugin 'fatih/vim-go'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'nanotech/jellybeans.vim'
Plugin 'evgenyzinoviev/vim-vendetta'
Plugin 'eshion/vim-sync'
Plugin 'vim-syntastic/syntastic'
"Plugin 'Nopik/vim-nerdtree-direnter'
"Plugin 'jistr/vim-nerdtree-tabs'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"Mappings for a tab
map <C-t> :NERDTreeToggle<CR>
"let g:NERDTreeMapOpenInTab='<CR>'
"let g:NERDTreeMapActivateNode='<CR>'


map <C-l> :bn<CR>
map <C-;> :bp<CR>
map <C-n> :tabnew<CR>
"nnoremap <C-U> <ESC>:call SyncUploadFile()<CR>
autocmd BufWritePost * :call SyncUploadFile()

"GUI vim options
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

"ColorScheme
set t_Co=256
syntax enable
set background=dark
"colorscheme solarized
colorscheme vendetta

"StatusLine Config
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
	  let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

"Syntatic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:pymode_options_max_line_length=500
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E302,E501,E225,E111'
let g:syntastic_javascript_checkers = ['eslint']

"Tag generation
let g:vim_tags_auto_generate = 1

" Map for functions
nmap <F8> :TagbarToggle<CR>
"let g:JSHintHighlightErrorLine = 0

"hi clear SpellBad
"hi SpellBad cterm=bold ctermfg=red
"
"
"let g:nerdtree_tabs_open_on_console_startup=1
