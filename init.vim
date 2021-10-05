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
let mapleader=" " 


call plug#begin('~/.local/share/nvim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'morhetz/gruvbox'
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
call plug#end()


" yank in main clipboard
set clipboard=unnamedplus


nmap <leader>T :enew<CR>
nmap <leader><Right> :bnext<CR>
nmap <leader><Left> :bnext<CR>
nmap <leader><Left> :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>



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
" Theming 
""""""""""""""""""""""""
colorscheme gruvbox
set background=dark



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
    require "lsp_signature".on_attach()  -- Note: add in lsp client on-attach
  end,
}
EOF
