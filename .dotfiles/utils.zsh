function edit-aliases() {
  cd ~/.dotfiles
  code .
}

function sync-aliases() {
    for file in ./*.zsh; do
        cp ${file##*/} $ZSH/custom/${file##*/}
        print "Copying ${file##*/} to $ZSH/custom/${file##*/}"
    done
}

# function symlink-aliases() { 
#     for file in ./*.zsh; do
#         if ! [ -L $ZSH_CUSTOM/${file##*/} ]; then
#             ln -s ${file##*/} $ZSH_CUSTOM/${file##*/}
#             print "linking $ZSH_CUSTOM/${file##*/}"
#         else
#             print "skipping $ZSH_CUSTOM/${file##*/}: Already exists"
#         fi
#     done
# } 

# CURRENTLY USING SPACESHIP PROMPT WITH OHMYZSH
# git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH/custom/themes/spaceship-prompt"
# ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/themes/spaceship.zsh-theme"