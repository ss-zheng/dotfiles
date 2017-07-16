" normal mode map {{{
nnoremap <silent> <CR> :w<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>
nnoremap <BS> :nohlsearch<CR>
nnoremap <silent> Q :q<CR>
nnoremap <silent> <C-l> :LLPStartPreview<CR> 
nnoremap L :bn<CR>
nnoremap H :bp<CR>
nnoremap - :bd<CR>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <space> za
" nnoremap s <Nop>
" nnoremap S <Nop>
" }}}

" insert mode map {{{
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
" }}}

"/* Forget meaning {{{ */
"let &t_SI = "\<Esc>[5 q"
"let &t_SR = "\<Esc>[3 q"
"let &t_EI = "\<Esc>[1 q"

