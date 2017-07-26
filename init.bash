#!/bin/bash 

home=$(echo ~)
file_list="vim vimrc zshrc bashrc tern-config"
for file in ${file_list}; do
    if [ -f "$home/.dotfiles/$file" ]; then
        ln -s "$home/.dotfiles/$file" "$home/.$file"
        if [ $? = 0 ]; then
            echo "Created symlink $home/.$file " "->" " $home/.dotfiles/$file" 1>&2
        fi
    else 
        echo "Error: $file does not exist." 1>&2
    fi
done
