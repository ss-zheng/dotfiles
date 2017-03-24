" Initialization {{{
" Basic {{{
set nocompatible
syntax on
filetype plugin indent on
set background=dark
" }}}

" Environment variables {{{
if has('win32')
    let $CONFIG = expand($USERPROFILE . '/AppData/Local')
else
    let $CONFIG = expand(empty($XDG_CONFIG_HOME) ? '~/.config' : $XDG_CONFIG_HOME)
endif

" Vim directory detection
if has('nvim')
    let $VIMDIR = expand($CONFIG . '/nvim')
else
    let $VIMDIR = expand(has('win32') ? '~/vimfiles' : '~/.vim')
endif
" }}}
" }}}

" Functions {{{
function! VMovement(key) " {{{
    " line-wise movement only when number is given
    return (v:count == 0 ? 'g' : '') . a:key
endfunction "}}}

function! HMovement(key) " {{{
    " screen movement only when wrap
    return (&wrap ? 'g' : '') . a:key
endfunction " }}}

function! BufferDelete(force) " {{{
    if &modified && !a:force
        Error 'No write since last change'
        return
    endif

    let num = bufnr('%')
    try
        bnext
    catch
    endtry

    try
        exec 'bdelete! ' . num
    catch
        Error 'Cannot delete current buffer'
    endtry
endfunction " }}}

function! Tab() " {{{
    let c = matchstr(getline('.'), '\%' . (col('.') - 1) . 'c\a')
    " complete if previous char is a letter
    return pumvisible() || !empty(c) ? "\<C-N>" : "\<Tab>"
endfunction " }}}

function! CtrlSpace() " {{{
    return pumvisible() ? "\<C-Y>" : "\<C-N>\<C-P>\<Down>"
endfunction " }}}

function! AutoPopupMenu() " {{{
    " show popup when inserting an identifier char
    if !pumvisible() && v:char =~ '\h'
        call feedkeys("\<C-N>\<C-P>")
    endif
endfunction " }}}

function! SyntaxInfo() " {{{
    let id = synID(line('.'), col('.'), 1)
    let tr = synIDtrans(id)

    let msg = synIDattr(id, 'name')

    if id != tr
        let msg .= ' -> ' . synIDattr(tr, 'name')
    endif

    return msg
endfunction " }}}

function! Write() " {{{
    if &buftype == ''
        return ":\<C-U>update\<CR>"
    endif

    return "\<CR>"
endfunction " }}}

function! LastUpdated() " {{{
    let time = getftime(expand('%:p'))
    let date = '%Y%m%d'

    if time < 0
        " no date info available
        return ''
    elseif strftime(date, time) == strftime(date, localtime())
        " same date, display time
        return strftime('%I:%M %p', time)
    else
        " different date, display date
        return strftime('%Y %m-%d', time)
    endif
endfunction " }}}

function! StatusLine() " {{{
    let status = ''
    let status .= ' %t '
    let status .= '%#TabLineSel# %<%(%{LastUpdated()} %)'
    let status .= '%m%r'
    let status .= '%='
    let status .= '%(%{&filetype} | %)%{&fileencoding}[%{&fileformat}] '
    let status .= '%* %3p%% : %3l/%L : %2v '
    return status
endfunction " }}}

function! Map(bang, args) " {{{
    " find the first whitespace, which separates modes from the command
    let idx = match(a:args, '\s')
    if idx >= 0
        " a key sequence given, call the map commands
        let modes = strpart(a:args, 0, idx)
        let cmd = (a:bang ? 'map' : 'noremap') . strpart(a:args, idx)
    else
        " no key sequence given, show all mappings for the modes
        let modes = a:args
        let cmd = 'map'
    endif

    for md in split(modes, '\zs')
        exec md . cmd
    endfor
endfunction " }}}

function! Has(...) " {{{
    for file in a:000
        if !filereadable($VIMDIR . file)
            return 0
        endif
    endfor

    return 1
endfunction " }}}

function! EscapeMagic(text) " {{{
    return substitute(a:text, '\.\|\*\|\\\|\[\|\^\|\$', '\\\0', 'g')
endfunction " }}}

function! FoldText() " {{{
    let text = getline(v:foldstart)

    " expand tabs
    let res = repeat(' ', &tabstop)
    let text = substitute(text, '\t', res, 'g')

    " remove commentstring
    if !empty(&commentstring)
        let pat = substitute(EscapeMagic(&commentstring), '%s', ' *\\|', '')
        let text = substitute(text, pat, '', 'g')
    endif

    " remove fold markers
    if &foldmethod == 'marker'
        let pat = substitute(EscapeMagic(&foldmarker), ',', '\\|', '')
        let pat = '\(' . pat . '\)\d*'
        let text = substitute(text, pat, '', 'g')
    endif

    " remove trailing whitespace when line not empty
    if !(text =~ '^\s*$')
        let text = substitute(text, '\s*$', ' ', '')
    endif

    let lines = v:foldend - v:foldstart
    return text . '[' . lines . ']'
endfunction " }}}

function! BufName(nr) " {{{
    let name = bufname(a:nr)

    let name = fnamemodify(name, ':t')

    if name == ''
        let name = '[No Name]'
    endif

    return name
endfunction " }}}

function! TabLine() " {{{
    let line = '%#StatusLine#'

    " if there are more than 1 tab
    if tabpagenr('$') > 1
        let line .= ' Tab '

        " for each tab
        for i in range(1, tabpagenr('$'))
            let line .= i == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
            let line .= '%' . i . 'T '

            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)

            let mod = ''

            if len(buflist) > 1
                " number of buffers in tab
                let mod .= string(len(buflist))
            endif

            for buf in buflist
                " add '+' if modified
                if getbufvar(buf, '&modified')
                    let mod .= '+'
                    break
                endif
            endfor

            if mod != ''
                let line .= mod . ' '
            endif

            " name of current buffer
            let line .= BufName(buflist[winnr - 1])

            let line .= ' '
        endfor
    else
        let line .= ' Buf '

        for i in range(1, bufnr('$'))
            if !buflisted(i)
                continue
            endif

            let line .= i == bufnr('%') ? '%#TabLineSel# ' : '%#TabLine# '

            if getbufvar(i, '&modified')
                let line .= '+ '
            endif

            " buffer name
            let line .= BufName(i)

            let line .= ' '
        endfor
    endif

    let line .= '%#TabLineFill#%T%=%#StatusLine#'

    let line .= ' %<%f '

    return line
endfunction " }}}
" }}}

" Commands {{{
" Map {{{
command! -nargs=1 -bang Map call Map(<bang>0, <q-args>)
" }}}

" Error {{{
command! -nargs=1 Error echohl ErrorMsg | echo <args> | echohl None
" }}}
" }}}

" Options {{{
" Variables {{{
let g:mapleader                 = ','
let g:tex_flavor                = 'latex'
let g:xml_syntax_folding        = 1
let g:c_comment_strings         = 1
let g:markdown_fenced_languages = ['c', 'cpp', 'scheme', 'haskell', 'sh', 'make']
" }}}

" Editing {{{
set autoindent                  " automatic indentation
set backspace=indent,eol,start  " backspace deletes everything
set belloff=all                 " don't ever ring the bell
set completeopt=menuone,preview " completion options
set encoding=utf-8              " UI and default encoding
set formatoptions+=j            " remove comment leader when joining lines
set hidden                      " don't unload buffer when switching to another
set mouse=a                     " enable all mouse operations
set mousefocus                  " mouse focus on hover
set mousemodel=extend           " right mouse extends selection
set nojoinspaces                " don't add space when joining paragraphs
set textwidth=80                " auto hard-break on 80 chars
set ttimeoutlen=10              " short timeout for <Esc> key
set updatetime=250              " reduce update interval
set whichwrap=h,l,<,>,[,]       " left, right, h, l go past lines
" }}}

" File {{{
set autoread                " auto read file when changed
set directory=$VIMDIR/swp   " swap file directory
set history=1000            " command line history
set nobackup                " no backup file
set nowritebackup           " don't backup before writing file
set sessionoptions-=options " don't store options in session files
set swapfile                " use swap files for recovery
set undodir=$VIMDIR/undo    " undo file directory
set undofile                " permanent undo history
set undolevels=1000         " how many undos in history
set undoreload=10000        " max lines for saving undo before reload
set viewdir=$VIMDIR/view    " view file directory
set viewoptions-=options    " don't store options when :mkview
" }}}

" Ignores {{{
" patterns to ignore for wild menu
set wildignore+=*.exe
set wildignore+=*.gz
set wildignore+=*.o
set wildignore+=*.pdf
set wildignore+=*.pyc
set wildignore+=*/.git/*
set wildignore+=*/__pycache__/*
set wildignore+=*/node_modules/*
set wildignore+=Thumbs.db
set wildignore+=desktop.ini

" suffixes that have a lower priority
set suffixes+=,
set suffixes+=.aux
set suffixes+=.d
set suffixes+=.fdb_latexmk
set suffixes+=.fls
set suffixes+=.log
" }}}

" Tabs {{{
set expandtab     " expand tab to spaces
set shiftround    " align indent to multiple of shiftwidth
set shiftwidth=4  " spaces to indent / unindent
set smarttab      " smarter tab insertion
set softtabstop=4 " spaces of a tab when editing
set tabstop=4     " spaces of a tab
" }}}

" Display {{{
set breakindent         " display indent when lines are wrapped
set colorcolumn=+1      " highlight textwidth
set conceallevel=2      " use symbols for conceal
set cursorline          " highlight current cursor line
set display=lastline    " show partial lines when too long
set fillchars=          " don't fill vert or fold
set foldclose=all       " auto close folds
set foldcolumn=2        " column to display folds
set foldlevel=10        " level of folds auto expanded
set foldmethod=syntax   " method to detect folds
set foldnestmax=10      " max level of folds
set foldtext=FoldText() " custom text to display on folded lines
set laststatus=2        " always show status line
set lazyredraw          " reduce redraw
set linebreak           " break at special chars
set noshowmatch         " don't jump cursor at matching brackets
set number              " line numbers
set previewheight=9     " height of preview window
set relativenumber      " relative line numbers
set ruler               " show status in status line
set scrolloff=5         " lines to always show before / after current line
set shortmess+=I        " no start screen
set showcmd             " show entered partial commands
set showmode            " show current editing mode
set showtabline=2       " always show tabline
set sidescrolloff=5     " columns to show in advance
set spell               " enables spell check by default
set spelllang=en_ca     " use Canadian English for spell checking
set splitbelow          " open horizontal splits to the bottom
set splitright          " open new split to the right by default
set title               " change terminal titles
set ttyfast             " send more escape sequences for better display
set wildmenu            " list completions in command mode
" }}}

" Statusline and tabline {{{
set statusline=%!StatusLine()
set tabline=%!TabLine()
" }}}

" Search {{{
set gdefault   " replace all instances by default
set ignorecase " ignore case when searching
set incsearch  " jump to nearest match when typing
set smartcase  " only lower case matches both upper and lower

" turn hlsearch on only when not set to avoid highlight after :source
if !&hlsearch
    set hlsearch " highlight all matches when searching
endif
" }}}

" Language mappings {{{
set langnoremap
set langmap+=[{}(=*)+]!;7531902468
set langmap+=7531902468;[{}(=*)+]!
" }}}
" }}}

" Mappings {{{
" Movement {{{
Map nx                 <C-H>   <C-W>h
Map nx                 <C-J>   <C-W>j
Map nx                 <C-K>   <C-W>k
Map nx                 <C-L>   <C-W>l
Map nx                 <C-C>   <C-W>c
Map nx          <expr> j       VMovement('j')
Map nx          <expr> k       VMovement('k')
Map nx          <expr> ^       HMovement('^')
Map nx          <expr> $       HMovement('$')
Map nx                 g$      $
Map nx                 g0      0
Map nx                 '       `
Map no <silent>        U       :<C-U>call search('\u')<CR>
" }}}

" Editing {{{
Map i <expr> <Tab>     pumvisible() ? "\<C-N>" : "\<Tab>"
Map i <expr> <S-Tab>   pumvisible() ? "\<C-P>" : ''
Map i        <C-B>     <C-G>U<Left>
Map i        <C-F>     <C-G>U<Right>
Map i        <C-E>     <C-G>U<End>
Map i        <C-U>     <C-G>u<C-U>
Map i        <C-C>     <C-]><Esc>
Map x        Y         "+y
Map x        D         "+d
Map x        P         "+p
Map x        R         y/\<<C-R>"\><CR>:redraw!<CR>:%s//
" }}}

" File {{{
Map n <silent> <expr> <CR> Write()
Map n <silent>        M    :<C-U>tabnew<CR>
Map n <silent>        H    :<C-U>bprevious<CR>
Map n <silent>        L    :<C-U>bnext<CR>
Map n <silent>        +    :<C-U>enew<CR>
Map n <silent>        -    :<C-U>call BufferDelete(0)<CR>
Map n <silent>        _    :<C-U>call BufferDelete(1)<CR>
Map n <silent>        ZF   :<C-U>cwindow 9<CR>
Map n <silent>        ZP   :<C-U>cprevious<CR>
Map n <silent>        ZN   :<C-U>cnext<CR>
" }}}

" Common files {{{
Map n <silent> <Leader>V :<C-U>edit $VIMDIR/init.vim<CR>
Map n <silent> <Leader>L :<C-U>edit $VIMDIR/local.vim<CR>
Map n <silent> <Leader>P :<C-U>edit $VIMDIR/plugins.vim<CR>
Map n <silent> <Leader>C :<C-U>edit $VIMDIR/colors/code.vim<CR>
Map n <silent> <Leader>A :<C-U>edit $VIMDIR/autoload/airline/themes/code.vim<CR>
Map n <silent> <Leader>R :<C-U>edit $VIMDIR/plugin/pairs.vim<CR>
Map n <silent> <Leader>I :<C-U>edit $CONFIG/i3/config<CR>
Map n <silent> <Leader>T :<C-U>edit $CONFIG/termite/config<CR>
Map n <silent> <Leader>Z :<C-U>edit $CONFIG/zathura/zathurarc<CR>
Map n <silent> <Leader>D :<C-U>edit $CONFIG/dunst/dunstrc<CR>
Map n <silent> <Leader>H :<C-U>edit $SystemRoot/System32/drivers/etc/hosts<CR>
Map n <silent> <Leader>S :<C-U>edit ~/.zshrc<CR>
Map n <silent> <Leader>B :<C-U>edit ~/.i3blocks.conf<CR>
Map n <silent> <Leader>X :<C-U>edit ~/.Xresources<CR>
Map n <silent> <Leader>M :<C-U>edit ~/.tmux.conf<CR>
Map n <silent> <Leader>G :<C-U>edit ~/.gitconfig<CR>
Map n <silent> <Leader>W :<C-U>edit ~/.vsvimrc<CR>
" }}}

" Misc {{{
Map nx <silent> Q         :<C-U>quitall<CR>
Map n  <silent> <BS>      :<C-U>nohlsearch<CR>
Map n  <silent> <Leader>s :<C-U>set spell!<CR>
Map n  <silent> <Leader>t :<C-U>! ~/test/test.sh % 3<CR>
Map n  <silent> <Leader>c :<C-U>echo SyntaxInfo()<CR>
" }}}
" }}}

" Abbreviations {{{

" }}}

" Highlight links {{{
" Gundo {{{
hi link diffAdded DiffAdd
hi link diffRemoved DiffDelete
" }}}

" Markdown {{{
hi link markdownCode Statement
" }}}

" HTML {{{
hi link htmlEndTag Delimiter
hi link htmlEvent PreProc
hi link htmlTag Delimiter
hi link htmlTagN htmlTagName
hi link javaScript Normal
" }}}

" JavaScript {{{
hi link javaScriptBraces Delimiter
hi link javaScriptGlobal Identifier
hi link javaScriptNull Constant
hi link javaScriptParens Delimiter
hi link javaScriptValue Constant
hi link jsFuncCall Function
" }}}

" CSS {{{
hi link cssAttrComma Delimiter
hi link cssBraces Delimiter
hi link cssFunctionComma Delimiter
" }}}

" XML {{{
hi link xmlEndTag Delimiter
hi link xmlEqual Operator
hi link xmlTag Delimiter
hi link xmlTagName Statement
" }}}

" TypeScript {{{
hi link typeScriptBraces Delimiter
hi link typeScriptLogicSymbols Operator
" }}}

" Python {{{
hi link pythonEscape SpecialChar
hi link pythonExceptions Type
" }}}

" Vim {{{
hi link vimIsCommand Statement
hi link vimSetSep Delimiter
hi link vimUserFunc Function
" }}}

" C++ {{{
hi link cppModifier StorageClass
hi link cppSTLexception Type
" }}}
" }}}

" Special cases {{{
" Diff mode {{{
if &diff
    " don't show cursorline and relativenumber when diff
    set nocursorline
    set norelativenumber
endif
" }}}

" Platform detection {{{
if has('gui_running') " GUI
    set guioptions-=L                   " left scrollbar
    set guioptions-=r                   " right scrollbar
    set guioptions-=T                   " toolbar
    set guioptions-=e                   " tabline

    set guiheadroom=0                   " don't leave space for gui
    set linespace=0                     " no space between lines

    if has('win32')
        set guifont=DejaVu_Sans_Mono:h9 " font
        set guioptions-=t               " teardown menus

        set lines=50                    " height
        set columns=160                 " width
    else
        set guifont=Monospace\ 9        " font
    endif
elseif has('nvim') " Nvim
    " tnoremap <Esc> <C-\><C-n>
elseif has('win32') " Windows
    " ignore terminal escape sequences
elseif &term=~'linux' " Virtual Terminal
    if has('terminfo')
        set t_Co=16
        " We use the blink attribute for bright background (console_codes(4)) and the
        " bold attribute for bright foreground. The redefinition of t_AF is necessary
        " for bright "Normal" highlighting to not influence the rest.
        set t_AB=[%?%p1%{7}%>%t5%p1%{8}%-%e25%p1%;m[4%dm
        set t_AF=[%?%p1%{7}%>%t1%p1%{8}%-%e22%p1%;m[3%dm
    endif
elseif &term=~'screen-256color' " Tmux
    if has('terminfo')
        set t_Co=256 " fix tmux 256 color detection
    endif
else " Terminal Emulator
    " change cursor shape in supported terminal emulators
    if has('terminfo')
        let &t_SI = "\<Esc>[5 q" " entering insert mode
        let &t_SR = "\<Esc>[3 q" " entering replace mode
        let &t_EI = "\<Esc>[1 q" " exiting insert mode
    endif
endif
" }}}
" }}}

" Setup {{{
" local.vim {{{
if Has('/local.vim')
    source $VIMDIR/local.vim
endif
" }}}

" Plugins {{{
if Has('/plugins.vim', '/autoload/plug.vim')
    call plug#begin()
    source $VIMDIR/plugins.vim
    call plug#end()
endif
" }}}

" Color scheme {{{
if Has('/colors/code.vim')
    let s:colors = expand('~/.colors')
    if filereadable(s:colors)
        let g:colors = readfile(s:colors)
    endif
    colorscheme code
endif
" }}}

" directory {{{
if !isdirectory(&directory)
    call mkdir(&directory, 'p')
endif
" }}}

" undodir {{{
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
endif
" }}}
" }}}

" Auto Commands {{{
augroup vimrc
    autocmd!

    " Resume last position {{{
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
    " }}}

    " Auto source / make on write {{{
    " TODO: monitor plugins.vim when loaded
    autocmd BufWritePost $VIMDIR/init.vim,$VIMDIR/local.vim
                \ source $MYVIMRC |
                \ setlocal filetype=vim
    autocmd BufWritePost $VIMDIR/spell/*.add
                \ mkspell! <afile>
    " }}}

    " Conceal markers {{{
    " au BufRead,BufNewFile *
    " \ syn match foldMarker contains= contained conceal /{{{[1-9]\?\|}}}[1-9]\?/
    " }}}

    " Auto popup menu {{{
    " TODO: resolve conflict with YCM
    " autocmd InsertCharPre * call AutoPopupMenu()
    " }}}

    " Undo file {{{
    autocmd BufWritePre /var/tmp/* setlocal noundofile
    " }}}

    if !&diff
        " Cursorline / colorcolumn {{{
        " autocmd InsertEnter * set nocursorline colorcolumn=+1
        " autocmd InsertLeave * set cursorline colorcolumn=
        " }}}

        " Auto-toggle relative number {{{
        " autocmd FocusGained,WinEnter * if &number | set relativenumber | endif
        " autocmd FocusLost,WinLeave * set norelativenumber
        " }}}
    endif
augroup END
" }}}
