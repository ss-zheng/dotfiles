" Basic {{{
" Plug 'vim-airline/vim-airline' " {{{

" let g:airline_theme = 'code'
" let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#ctrlp#color_template     = 'normal'
let g:airline#extensions#hunks#non_zero_only      = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#enabled          = 1
let g:airline#extensions#tabline#exclude_preview  = 1
let g:airline#extensions#tabline#show_buffers     = 1
let g:airline_exclude_preview                     = 1
let g:airline_skip_empty_sections                 = 1
" let g:airline_symbols.branch = '⌥'
" let g:airline_symbols.linenr = '№'
let g:airline#extensions#tabline#left_alt_sep  = '│'
let g:airline#extensions#tabline#left_sep      = '▌'
let g:airline#extensions#tabline#right_alt_sep = '│'
let g:airline#extensions#tabline#right_sep     = '▐'
let g:airline_left_alt_sep                     = '│'
let g:airline_left_sep                         = '▌'
let g:airline_right_alt_sep                    = '│'
let g:airline_right_sep                        = '▐'
" let g:airline_section_y = airline#section#create_left(['%{strftime("%c", getftime(expand("%:p")))}'])
" Plug 'andrewradev/splitjoin.vim'
" Plug 'jiangmiao/auto-pairs'
" Plug 'xolox/vim-session'
" }}}

Plug 'easymotion/vim-easymotion' " {{{

" let g:EasyMotion_leader_key = ','
" }}}

Plug 'junegunn/vim-easy-align' " {{{

Map! nx ga <Plug>(EasyAlign)
" }}}

Plug 'haya14busa/incsearch.vim' " {{{

Map! nxo /  <Plug>(incsearch-forward)
Map! nxo ?  <Plug>(incsearch-backward)
Map! nxo g/ <Plug>(incsearch-stay)
" }}}

" Plug 'sickill/vim-pasta' " {{{
" }}}

Plug 'terryma/vim-multiple-cursors' " {{{
" }}}

Plug 'tpope/vim-commentary' " {{{
" }}}

Plug 'tpope/vim-repeat' " {{{
" }}}

Plug 'tpope/vim-surround' " {{{
" }}}

Plug 'Shougo/unite.vim' " {{{

Map n <silent> <Space> :<C-U>Unite -start-insert file<CR>
" }}}

" Plug 'flazz/vim-colorschemes' " {{{
" }}}
" }}}

" Filetypes {{{
Plug 'tpope/vim-markdown' " {{{
" }}}

Plug 'mattn/emmet-vim', { 'for': 'html' } " {{{
" }}}

Plug 'octol/vim-cpp-enhanced-highlight' " {{{
" }}}

Plug 'pangloss/vim-javascript' " {{{
" }}}

Plug 'wlangstroth/vim-racket' " {{{

let g:markdown_fenced_languages += ['racket']
" }}}

Plug 'leafgarland/typescript-vim' " {{{
" }}}

" Plug 'hdima/python-syntax' " {{{
" " }}}

Plug 'OrangeT/vim-csharp' " {{{
" }}}

Plug 'rust-lang/rust.vim' " {{{
" }}}
" }}}

if !has('nvim') " {{{
    " Plug 'jeaye/color_coded' {{{
    " }}}
endif " }}}

if has('win32') " {{{
    Plug 'xolox/vim-misc' " {{{
    " }}}

    Plug 'xolox/vim-shell' " {{{
    " }}}
endif " }}}

if has('python') " {{{
    Plug 'sjl/gundo.vim' " {{{

    Map n <silent> <C-G> :<C-U>GundoToggle<CR>

    let g:gundo_close_on_revert = 1
    let g:gundo_preview_bottom  = 1
    " }}}
endif " }}}

if executable('git') " {{{
    Plug 'airblade/vim-gitgutter' " {{{

    let g:gitgutter_override_sign_column_highlight = 0

    hi link GitGutterAdd DiffAdd
    hi link GitGutterChange DiffChange
    hi link GitGutterDelete DiffDelete
    hi link GitGutterChangeDelete DiffChange
    " }}}

    Plug 'tpope/vim-fugitive' " {{{
    " }}}
endif " }}}

if executable('latex') " {{{
    Plug 'lervag/vimtex' " {{{
    " }}}
endif " }}}

if executable('ctags') " {{{
    Plug 'majutsushi/tagbar' " {{{

    Map n <silent> <C-T> :<C-U>TagbarToggle<CR>

    let g:tagbar_autoclose   = 1
    let g:tagbar_autopreview = 1
    let g:tagbar_sort        = 0
    " }}}
endif " }}}

" Heavy-weight / non-file editing plugins {{{
if argc() == 0
    " Plug 'ctrlpvim/ctrlp.vim' " {{{

    " let g:ctrlp_cmd = 'CtrlPMixed'
    " let g:ctrlp_user_command = 'ag %s -l --depth 3 --nocolor --hidden -g ""'
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_max_depth   = 3
    " }}}

    if exists('g:completion') && (has('python') || has('python3')) " {{{
        Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' " {{{

        let g:UltiSnipsExpandTrigger = '<C-j>'
        " }}}

        Plug 'Valloric/YouCompleteMe' " {{{

        " let g:ycm_autoclose_preview_window_after_completion = 1
        let g:ycm_autoclose_preview_window_after_insertion = 1
        let g:ycm_confirm_extra_conf                       = 0
        let g:ycm_global_ycm_extra_conf                    = '~/.ycm_extra_conf.py'
        let g:ycm_min_num_of_chars_for_completion          = 1
        let g:ycm_seed_identifiers_with_syntax             = 1
        if has('win32')
            let g:ycm_server_python_interpreter = 'C:\Program Files\Python35\python.exe'
        else
            let g:ycm_server_python_interpreter = '/usr/bin/python3'
        endif
        " }}}
    endif " }}}

    " Plug 'itchyny/calendar.vim'
    " Plug 'xolox/vim-notes'
endif
" }}}
