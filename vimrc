set encoding=utf-8
filetype plugin indent on " enables filetype detection, enable filetype-specific scripts (ftplugins), enables filetype-specific indent script

source ~/.vim/default.vim
source ~/.vim/keyMap.vim
source ~/.vim/plugin.vim

augroup vimrc
    " Resume last position {{{
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
    " }}}
    autocmd FileType tex,text setlocal spell " set spell for tex and txt files
    autocmd Filetype tex setl updatetime=1000
augroup END

if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
endif
