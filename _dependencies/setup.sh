#!/usr/bin/env bash

echo "clone prezto"
# git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

echo "clone zsh-histdb"
mkdir -p $HOME/.oh-my-zsh/custom/plugins/
git clone https://github.com/larkery/zsh-histdb $HOME/.oh-my-zsh/custom/plugins/zsh-histdb
