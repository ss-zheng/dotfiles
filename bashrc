# sourced if is not login shell
[[ $- != *i* ]] && return

if [ -f "/etc/profile.d/vte.sh" ];then
    source /etc/profile.d/vte.sh  #open the shell under the same directory
fi

if [ -r "/usr/share/bash-completion/bash_completion" ]; then
	source "/usr/share/bash-completion/bash_completion"
fi

source ~/.dotfiles/alias
source ~/.dotfiles/shell-func

if [[ -n $SSH_CONNECTION ]]; then
    PS1='\[\033[1;32m\]ssh \w\n\[\033[1;34m\]...\[\033[0m\] '
else
    PS1='\[\033[1;32m\] \w\n\[\033[1;34m\]...\[\033[0m\] '
fi
 
export HISTCONTROL=ignoreboth:erasedups # history ignore duplicate commands
