#!/usr/bin/env bash

set -e
DEST=${HOME}/_UTIL

if [ ! -d "$DEST" ]; then
  mkdir -p "$DEST"
fi

pushd "$DEST"

git clone git@github.com:elixir-lsp/elixir-ls.git
pushd elixir-ls
  mkdir rel
  yes | mix deps.get
  yes | mix compile
  yes | mix elixir_ls.release -o rel
  ln -s $(pwd)/rel $HOME/elixir-ls
popd


