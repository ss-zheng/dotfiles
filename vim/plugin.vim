call plug#begin()
     Plug 'tpope/vim-commentary'
     Plug 'Valloric/YouCompleteMe'
     Plug 'altercation/vim-colors-solarized'
     Plug 'kien/ctrlp.vim'
     Plug 'tpope/vim-surround'
     Plug 'scrooloose/syntastic'
     Plug 'scrooloose/nerdtree'
     Plug 'tpope/vim-fugitive'
     Plug 'pangloss/vim-javascript'
call plug#end()

" settings for ctrlp
nnoremap fu :CtrlPFunky<CR>

" Pathogen
execute pathogen#infect()

" settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"# settings for nerdtree
map <C-n> :NERDTreeToggle<CR>
"## close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" settings for vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
set foldmethod=syntax
map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"
