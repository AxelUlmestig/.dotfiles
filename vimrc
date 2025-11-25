filetype plugin indent on
syntax on
set number
set clipboard+=unnamedplus

set noswapfile
set nobackup
set nowb
set nowrap

set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

set vb

set path=.,,**

call plug#begin('~/.config/nvim/vimplug')

Plug 'scrooloose/nerdtree'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline' 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"requires the silver searcher: https://github.com/ggreer/the_silver_searcher
"  and ag: sudo apt install silversearcher-ag
Plug 'mileszs/ack.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rails'
"Plug 'tpope/vim-fugitive'
""requires ghc-mod: $ stack install hlint ghc-mod
"Plug 'eagletmt/ghcmod-vim'
"requires stylish-haskell: $ stack install stylish-haskell
Plug 'nbouscal/vim-stylish-haskell'
"requires hindent: $ stack install hindent
"Plug 'alx741/vim-hindent'
Plug 'leafgarland/typescript-vim'
"Plug 'andys8/vim-elm-syntax'
Plug 'elmcast/elm-vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'neovim/nvim-lsp'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'
Plug 'ervandew/supertab'
Plug 'Chiel92/vim-autoformat'

Plug 'neovim/nvim-lspconfig'
Plug 'github/copilot.vim'
Plug 'rust-lang/rust.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"color scheme
Plug 'rebelot/kanagawa.nvim'

call plug#end()

colorscheme kanagawa

"silver searcher ag integration
let g:ackprg = 'ag --nogroup --nocolor --column'

map <C-p> :FZF<CR>
map <C-f> :Ag<CR>
map <C-n> :NERDTreeToggle<CR>
map <C-b> :NERDTreeFind<CR>

"copy current file path
let mapleader = ","
nnoremap <leader>Y :let @+ = expand('%:p')<CR>
nnoremap <leader>y :let @+ = expand('%')<CR>

"format json
nnoremap <leader>j :%! jq .<CR>

"ctags
set tags=./tags;

"close tabs to the right
map <C-k> :.+1,$tabdo :tabc<CR>

"ale configuration
let g:ale_linters = {
\ 'sql': ['sqlint'],
\ 'haskell': ['hlint'],
\ 'bash': ['shellcheck']
\}

"rustfmt on save
let g:rustfmt_autosave = 1

"sqlformat comes from this repo https://github.com/andialbrecht/sqlparse
"% gets expanded to current filename
"autocmd BufWritePost *.sql silent execute "%!sqlformat --reindent --keywords lower --indent_width 2 --indent_after_first --indent_columns %" | w

""coc stuff
"" use <tab> for trigger completion and navigate to the next complete item
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"
"inoremap <silent><expr> <Tab>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<Tab>" :
"      \ coc#refresh()
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"
"inoremap <silent><expr> <Tab>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<Tab>" :
"      \ coc#refresh()
"
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"set the text colour
highlight CocErrorFloat ctermfg=black
highlight CocWarningFloat ctermfg=black
highlight CocInfoFloat ctermfg=black
highlight CocHintFloat ctermfg=black

"LSP config
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<C-.>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'hls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

lua <<EOF

require('nvim-treesitter.configs').setup({
  ensure_installed = { "haskell", "lua", "python", "javascript", "typescript", "rust" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

EOF
