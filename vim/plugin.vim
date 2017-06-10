call plug#begin()
     Plug 'tpope/vim-commentary'
     Plug 'Valloric/YouCompleteMe'
     Plug 'altercation/vim-colors-solarized'
     Plug 'kien/ctrlp.vim'
     Plug 'tpope/vim-surround'
     Plug 'scrooloose/syntastic'
     Plug 'scrooloose/nerdtree'
     Plug 'tpope/vim-fugitive'
call plug#end()

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
