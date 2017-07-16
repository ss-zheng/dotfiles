if [ -f "~/.profile" ]; then
    source ~/.profile
fi

source ~/.dotfiles/alias

LS_COLOR='di=95:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS

export EDITOR=vi
PS1='\[\033[1;32m\] \w
\[\033[1;34m\]...\[\033[0m\] '
