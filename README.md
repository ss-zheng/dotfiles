#.dotfiles

Personal dotfiles settings (.vim, .ssh)

## Get Started

Getting the source

```
git clone https://github.com/ss-zheng/dotfiles.git
```

## Settings

Inside your .vimrc you can source different file to gain different vim features.

```
source ./.dotfiles/vim/default.vim 
source ./.dotfiles/vim/keyMap.vim
source ./.dotfiles/vim/plugin.vim
```

NOTE: This vim setting use vim-plug as vim plugin manager.
Run :PlugInstall inside vim to enable plugins
