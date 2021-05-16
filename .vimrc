syntax on


set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undostore
set undofile
set incsearch

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey


call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'dylon/vim-antlr'
Plug 'govim/govim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'git@github.com:ctrlpvim/ctrlp.vim.git'
call plug#end()

colorscheme gruvbox
set background=dark
let mapleader=" " 

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_use_caching = 0

" yank in main clipboard
set clipboard=unnamedplus

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :NERDTree<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent><leader>= :vertical resize +5<CR>
nnoremap <silent><leader>- :vertical resize -5<CR>
nnoremap <leader>tv :below vert term<CR>
nnoremap <leader>th :below term<CR>

" tab management 
let g:airline#extensions#tabline#enabled = 1
set hidden
nmap <leader>T :enew<CR>
nmap <leader><Right> :bnext<CR>
nmap <leader><Left> :bnext<CR>
nmap <leader><Left> :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>


" golang hint
nmap <silent> <buffer> <Leader>h :<C-u>call GOVIMHover()<CR>

" autocompletion
function! Omni()
    call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
                    \ 'name': 'omni',
                    \ 'whitelist': ['go','perl','python','c','javascript'],
                    \ 'completor': function('asyncomplete#sources#omni#completor')
                    \  }))
endfunction

au VimEnter * :call Omni()

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif


