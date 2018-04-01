function edit-aliases() {
  cd ~/.dotfiles
  code .
}

function sync-aliases() {
    for file in ./*.zsh; do
        cp ${file##*/} $ZSH_CUSTOM/${file##*/}
        print "Copying ${file##*/} to $ZSH_CUSTOM/${file##*/}"
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
