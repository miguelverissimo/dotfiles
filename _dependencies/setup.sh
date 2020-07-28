#!/usr/bin/env bash

if [[ $(command -v yay) ]]; then
  yay -S prezto-git
else
  ZDOTDIR="$HOME/.zprezto"
  if [[ -d "${ZDOTDIR:-$HOME}/.zprezto" ]]; then
    echo "prezto seems to be installed"
  else
    echo "clone prezto"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  fi
fi
