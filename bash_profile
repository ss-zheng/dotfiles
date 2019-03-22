# vim: ft=sh
# sourced if is login shell
if [ -e $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi

# bourn shell compatible shell should source .profile
if [ -f "~/.profile" ]; then
    source ~/.profile
fi

source $HOME/.dotfiles/env
source $HOME/.dotfiles/path
