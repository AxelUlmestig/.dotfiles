filetype plugin indent on
syntax on
set number
set clipboard+=unnamedplus

set noswapfile
set nobackup
set nowb

"tabs as spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=8 smarttab

call plug#begin('~/.config/nvim/plugins')

"nerdtree
Plug 'https://github.com/scrooloose/nerdtree'

"elm
Plug 'https://github.com/ElmCast/elm-vim'

call plug#end()
