filetype plugin indent on " enables filetype detection, enable filetype-specific scripts (ftplugins), enables filetype-specific indent script

source ~/.vim/colorSkin.vim
source ~/.vim/default.vim
source ~/.vim/plugin.vim
source ~/.vim/keyMap.vim

let g:livepreview_prevautocmdiewer='xdg-open'
" autocmd Filetype tex setl updatetime=1000


" Resume last position {{{
autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif
" }}}
