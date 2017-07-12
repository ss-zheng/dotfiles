# .dotfiles

Personal dotfiles settings (.vim, .ssh, .vimrc)

## Get Started

Getting the source

```
git clone https://github.com/ss-zheng/dotfiles.git
```

## Settings

Move .vimrc to your home directory  
Make sure VimPlug is installed  

Change colorSkin.vim for color settings  
Change default.vim for default settings  
Change plugin.vim for plugin settings  
Change keyMap.vim for key map settings  

```
source ./.dotfiles/vim/default.vim 
source ./.dotfiles/vim/keyMap.vim
source ./.dotfiles/vim/plugin.vim
```

NOTE: This vim setting use vim-plug as vim plugin manager.  
Run :PlugInstall inside vim to enable plugins  
