#!/usr/bin/env bash

if [[ -d "${ZDOTDIR:-$HOME}/.zprezto" ]]; then
  echo "prezto seems to be installed"
else
  echo "clone prezto"
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi
