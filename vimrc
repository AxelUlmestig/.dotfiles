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

lua << EOF
  vim.pack.add({
    'https://github.com/preservim/nerdtree',

    -- sudo apt install -y ripgrep fd-find
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',

    'https://github.com/vim-airline/vim-airline',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/rebelot/kanagawa.nvim', -- colour scheme
  })
EOF

" call plug#begin('~/.config/nvim/vimplug')
"
" Plug 'scrooloose/nerdtree'
" Plug 'dense-analysis/ale'
" Plug 'vim-airline/vim-airline'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
" "requires the silver searcher: https://github.com/ggreer/the_silver_searcher
" "  and ag: sudo apt install silversearcher-ag
" Plug 'mileszs/ack.vim'
" Plug 'itchyny/lightline.vim'
" Plug 'tpope/vim-surround'
" Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-rails'
" Plug 'leafgarland/typescript-vim'
" "Plug 'andys8/vim-elm-syntax'
" Plug 'elmcast/elm-vim'
" "Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
" Plug 'neovim/nvim-lsp'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/deoplete-lsp'
" Plug 'ervandew/supertab'
" Plug 'Chiel92/vim-autoformat'
"
" Plug 'neovim/nvim-lspconfig'
" "Plug 'github/copilot.vim'
" Plug 'rust-lang/rust.vim'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"
" "color scheme
" Plug 'rebelot/kanagawa.nvim'
"
" call plug#end()

colorscheme kanagawa

"silver searcher ag integration
let g:ackprg = 'ag --nogroup --nocolor --column'

" map <C-p> :FZF<CR>
map <C-p> :Telescope find_files<CR>
" map <C-f> :Ag<CR>
map <C-f> :Telescope live_grep<CR>
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

"set the text colour
highlight CocErrorFloat ctermfg=black
highlight CocWarningFloat ctermfg=black
highlight CocInfoFloat ctermfg=black
highlight CocHintFloat ctermfg=black

"LSP config
lua << EOF
vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.config('hs_ls', {
  cmd = { 'haskell-language-server-wrapper', '--lsp' },
  filetypes = { 'haskell' },
  root_markers = { 'cabal.project', '*.cabal' },
  settings = {
    haskell = {
      formattingProvider = "stylish-haskell"
    }
  },
})

vim.lsp.enable('hs_ls')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- LSP keymaps (when LSP attaches)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- Show diagnostics when cursor stays in place
vim.api.nvim_create_autocmd({ 'CursorHold' }, {
  callback = function()
    -- Check if there are diagnostics at the cursor position
    local diag = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
    if #diag > 0 then
      vim.diagnostic.open_float(nil, {
        focusable = false,
        close_events = {
          'CursorMoved',
          'CursorMovedI',
          'BufHidden',
          'InsertCharPre',
          'WinLeave',
        },
        border = 'rounded',
        source = true,
        prefix = '',
      })
    end
  end,
})

-- Time (in ms) until the CursorHold kicks in. Default is 4000 ms
vim.o.updatetime = 300

-- Auto-format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.hs',
  callback = function()
    vim.lsp.buf.format({ name = "hs_ls" })
  end,
})

EOF

