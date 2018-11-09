if [ -f "~/.profile" ]; then
    source ~/.profile
fi

if [ -f "/etc/profile.d/vte.sh" ];then
    source /etc/profile.d/vte.sh  #open the shell under the same directory
fi

if [ -r "/usr/share/bash-completion/bash_completion" ]; then
	source "/usr/share/bash-completion/bash_completion"
fi

source ~/.dotfiles/alias
source ~/.dotfiles/shell-func

LS_COLOR='di=95:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS

export EDITOR=vi

if [[ -n $SSH_CONNECTION ]]; then
    PS1='\[\033[1;32m\]ssh \w\n\[\033[1;34m\]...\[\033[0m\] '
else
    PS1='\[\033[1;32m\] \w\n\[\033[1;34m\]...\[\033[0m\] '
fi

# export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
# export HISTCONTROL=ignoreboth:erasedups

# if [ -x /bin/showpath ]; then
#     PATH=`/bin/showpath /u/cs350/sys161/bin /u/cs350/bin standard`$PATH
# fi
export PATH="$HOME/Library/Python/3.6/bin:$HOME/bin:$HOME/.local/bin:$PATH"
