filetype plugin indent on " enables filetype detection, enable filetype-specific scripts (ftplugins), enables filetype-specific indent script

source ~/.dotfiles/vim/colorSkin.vim
source ~/.dotfiles/vim/default.vim
source ~/.dotfiles/vim/plugin.vim
source ~/.dotfiles/vim/keyMap.vim

let g:livepreview_prevautocmdiewer='xdg-open'
" autocmd Filetype tex setl updatetime=1000


" Resume last position {{{
autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif
" }}}
