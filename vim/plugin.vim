call plug#begin()
     Plug 'Valloric/YouCompleteMe'
     Plug 'airblade/vim-gitgutter'
     Plug 'kien/ctrlp.vim'
     Plug 'lervag/vimtex'
     Plug 'mattn/emmet-vim'
     Plug 'mxw/vim-jsx'
     Plug 'pangloss/vim-javascript'
     Plug 'scrooloose/nerdtree'
     Plug 'scrooloose/syntastic'
     Plug 'sjl/gundo.vim'
     Plug 'ternjs/tern_for_vim'
     Plug 'tpope/vim-commentary'
     Plug 'tpope/vim-fugitive'
     Plug 'tpope/vim-surround'
     Plug 'vim-airline/vim-airline'
     Plug 'vim-airline/vim-airline-themes'
	 " Plug 'MaxSt/FlatColor'
     Plug 'altercation/vim-colors-solarized'
call plug#end()

" settings for ycm {{{
" let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1  "colse auto complete when quiting the insert mode
let g:ycm_confirm_extra_conf                       = 1  "when existing local python conf file, include with out asking
let g:ycm_min_num_of_chars_for_completion          = 1  "start completion after typing one character
let g:ycm_seed_identifiers_with_syntax             = 1 "auto complete language key words
let g:ycm_global_ycm_extra_conf = "~/.dotfiles/ycm_extra_conf.py" "set global ycm extra conf path
let g:ycm_extra_conf_globlist = ['~/cs350-os161/99/.ycm_extra_conf.py']
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^\s{4}', 're!:\s+' ],
    \ } 
" }}}

" settings for jsx {{{
let g:jsx_ext_required = 0 " apply jsx syntax hightlight, indent with .js files
"let g:jsx_pragma_required = 1 " apply js syntax hightlight, indent with pre-v0.12 @jsx React.DOM pragma
" }}}

" settings for airline {{{
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 "show up powerline fonts
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
" }}}

" settings for gundo {{{
nnoremap <F5> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 15 
let g:gundo_right = 0 " gui show up on the right side
" }}}

" settings for emmet-vim {{{
" let g:user_emmet_mode='n'    "only enable normal mode functions.
" let g:user_emmet_mode='inv'  "enable all functions, which is equal to
" let g:user_emmet_mode='a'    "enable all function in all mode

" let g:user_emmet_install_global = 0 "enable just for html/css
" autocmd FileType html,css EmmetInstall.
" }}}

" settings for ctrlp {{{
nnoremap fu :CtrlPFunky<CR>
" }}}

" settings for syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"}}}

" settings for nerdtree {{{
map <C-n> :NERDTreeToggle<CR>
"## close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"}}}

" settings for vim-javascript {{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
" set foldmethod=syntax
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
" }}}
