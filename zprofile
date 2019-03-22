# vim: ft=zsh
source $HOME/.dotfiles/path

# auto start tmux
if [[ -n "$SSH_CONNECTION" && -z "$TMUX" ]] && (( $+commands[tmux] ));then
    if tmux attach || tmux new -s dev; then
        exit
    fi
fi
