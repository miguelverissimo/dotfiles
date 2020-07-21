#!/usr/bin/env bash

set -e

cat << EOF > "../zsh/keyboard.zsh"
xset r rate 300 50

# https://superuser.com/questions/566871/how-to-map-the-caps-lock-key-to-escape-key-in-arch-linux
setxkbmap -option caps:escape
EOF
