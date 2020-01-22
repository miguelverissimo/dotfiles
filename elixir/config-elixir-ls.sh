#!/usr/bin/env bash

set -e

if [ ! -d "$HOME/workspace/_util" ]; then
  mkdir -p $HOME/workspace/_util
fi

pushd $HOME/workspace/_util

git clone git@github.com:elixir-lsp/elixir-ls.git
pushd elixir-ls
  mkdir rel
  yes | mix deps.get
  yes | mix compile
  yes | mix elixir_ls.release -o rel
  ln -s $(pwd)/rel $HOME/elixir-ls
popd


