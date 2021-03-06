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
Plug 'tpope/vim-fugitive'
""requires ghc-mod: $ stack install hlint ghc-mod
"Plug 'eagletmt/ghcmod-vim'
"requires stylish-haskell: $ stack install stylish-haskell
Plug 'nbouscal/vim-stylish-haskell'
"requires hindent: $ stack install hindent
"Plug 'alx741/vim-hindent'
Plug 'leafgarland/typescript-vim'
Plug 'andys8/vim-elm-syntax'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"silver searcher ag integration
let g:ackprg = 'ag --nogroup --nocolor --column'

map <C-p> :FZF<CR>
map <C-f> :Ag<CR>
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>

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

"sqlformat comes from this repo https://github.com/andialbrecht/sqlparse
"% gets expanded to current filename
"autocmd BufWritePost *.sql silent execute "%!sqlformat --reindent --keywords lower --indent_width 2 --indent_after_first --indent_columns %" | w

"coc stuff
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"set the text colour
highlight CocErrorFloat ctermfg=black
highlight CocWarningFloat ctermfg=black
highlight CocInfoFloat ctermfg=black
highlight CocHintFloat ctermfg=black
