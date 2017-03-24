call plug#begin()
    Plug 'tpope/vim-commentary'
call plug#end()

"filetype plugin indent on
"set mouse=a
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
set showcmd
set tabstop=4
set expandtab
set softtabstop=4
set cursorline
set showmatch
set incsearch
set hlsearch
set foldenable
set wildmenu
set lazyredraw
set number
set smartindent
set shiftwidth=4

set relativenumber
set scrolloff=5
"set whichwrap=h,l,<,>,[,]
set undodir=/u5/s7zheng/.vim/undo    " undo file directory
set undofile                " permanent undo history
set undolevels=1000         " how many undos in history
set undoreload=10000        " max lines for saving undo before reload

nnoremap <silent> <CR> :w<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>
nnoremap <BS> :nohlsearch<CR>
" nnoremap <silent> Q :q<CR>

nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>

"let &t_SI = "\<Esc>[5 q"
"let &t_SR = "\<Esc>[3 q"
"let &t_EI = "\<Esc>[1 q"

" Resume last position {{{
autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif
" }}}
