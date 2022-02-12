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
set number relativenumber
set mmp=5000
set mouse=a
let mapleader=" " 


call plug#begin('~/.local/share/nvim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/toggleterm.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'ryanoasis/vim-devicons'
Plug 'kdheepak/tabline.nvim'
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" themes plugins
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'chriskempson/base16-vim'
Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

""""""""""""""""""""""""
" Theming 
""""""""""""""""""""""""
" colorscheme onehalflight
" colorscheme base16-default-dark
colorscheme gruvbox
" colorscheme palenight
set background=dark
" colorscheme tokyonight




" yank in main clipboard
set clipboard=unnamedplus


nmap <leader>T :enew<CR>
nmap <leader><Right> :bnext!<CR>
nmap <leader><Left> :bprevious!<CR>
nmap <leader>bq :bp <BAR> bd #<CR>

nmap <leader>nonu :set norelativenumber<CR> :set nonumber<CR>
nmap <leader>nu :set number<CR> :set relativenumber<CR>

" Lint file on save
"let g:syntastic_go_checkers = ['go', 'golint', 'govet']
"autocmd BufWritePre *.go :GoBuild

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" plugins properties

lua << EOF
require'tabline'.setup {
      -- Defaults configuration options
      enable = true,
      options = {
      -- If lualine is installed tabline will use separators configured in lualine by default.
      -- These options can be used to override those settings.
        section_separators = {'', ''},
        component_separators = {'', ''},
        max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = true, -- this shows devicons in buffer section
        show_bufnr = false, -- this appends [bufnr] to buffer section,
        show_filename_only = false, -- shows base filename only instead of relative path in filename
      }
}

EOF

""""""""""""""""""""""""
" nvim line 
""""""""""""""""""""""""
lua << EOF
require('lualine').setup()
EOF



""""""""""""""""""""""""
" Telescope bindings
""""""""""""""""""""""""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

""""""""""""""""""""""""
" Auto Completion
""""""""""""""""""""""""
set completeopt=menu,menuone,noselect
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })
EOF

""""""""""""""""""""""""
" TreeSitter - highlight code
""""""""""""""""""""""""
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF



""""""""""""""""""""""""
" Git signs
""""""""""""""""""""""""
lua << EOF
require('gitsigns').setup()
EOF

nmap <leader>df :Gitsigns diffthis<CR>
nmap <leader>ph :Gitsigns preview_hunk<CR>

""""""""""""""""""""""""
" Nvim tree
""""""""""""""""""""""""
lua << EOF
require'nvim-tree'.setup()
EOF
nnoremap <leader>\ :NvimTreeToggle<CR>


""""""""""""""""""""""""
" Terminal
""""""""""""""""""""""""
lua << EOF
require'toggleterm'.setup()
EOF


""""""""""""""""""""""""
" Golang LSP
""""""""""""""""""""""""
lua << EOF
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'

if not lspconfig.golangcilsp then
 	configs.golangcilsp = {
		default_config = {
			cmd = {'golangci-lint-langserver'},
			root_dir = lspconfig.util.root_pattern('.git', 'go.mod', 'main.go'),
			init_options = {
					-- command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json" };
					command = { "golangci-lint", "run", "--out-format", "json" };
			}
		};
	}
end
lspconfig.golangcilsp.setup {
	filetypes = {'go'}
}
EOF

lua << EOF
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

configs.gopls = {
  default_config = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod' },
    root_dir = function(fname)
      return util.root_pattern 'go.work'(fname) or util.root_pattern('go.mod', '.git', 'main.go')(fname)
    end,
  }
}

lspconfig.gopls.setup{
 on_attach = function(client, bufnr)
    require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) -- Note: added from completion plugin
    require "lsp_signature".on_attach({
        bind=true,
        hint_enable=true,
        hanlder_opts={
            border="rounded"
            }
    }, bufnr)  -- Note: add in lsp client on-attach
  end,
}
EOF


lua << EOF
require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = false,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  }
}
EOF


