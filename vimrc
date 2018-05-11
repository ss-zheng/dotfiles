set encoding=utf-8
filetype plugin indent on " enables filetype detection, enable filetype-specific scripts (ftplugins), enables filetype-specific indent script

source ~/.vim/default.vim
source ~/.vim/keyMap.vim
source ~/.vim/plugin.vim

let g:livepreview_prevautocmdiewer='xdg-open' "latex live preview
" autocmd Filetype tex setl updatetime=1000

augroup vimrc
" Resume last position {{{
autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif
" }}}
" autocmd FileType *.c setlocal noexpandtab tabstop=8
augroup END

if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
endif
