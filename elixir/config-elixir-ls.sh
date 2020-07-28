#!/usr/bin/env bash

set -e
DEST=${HOME}/_UTIL

if [ ! -d "$DEST" ]; then
  mkdir -p "$DEST"
fi

# make sure asdf is sourced and elixir has a default or this will fail
ASDF_PATH="$HOME/.asdf/asdf.sh"
if [[ -f "$ASDF_PATH" ]]; then
  source "$ASDF_PATH"
else
  echo "Can't find asdf @ $ASDF_PATH, exiting"
  exit 99
fi

pushd "$DEST"

if [[ -e "$HOME/elixir-ls" ]]; then
  echo "elixir-ls seems to already be installed, exiting"
  exit 0
fi

if [[ -d "elixir-ls" ]]; then
  echo "elixir-ls repo seems to already exist"
  pushd elixir-ls
    git pull
  popd
else
  git clone git@github.com:elixir-lsp/elixir-ls.git
fi

pushd elixir-ls
  if [[ ! -d "rel" ]]; then mkdir rel; fi

  # asdf install erlang 20.3.8.23
  # asdf local erlang 20.3.8.23
  # asdf install elixir 1.7.4-otp-20
  # asdf local elixir 1.7.4-otp-20

  yes | mix deps.get
  yes | mix compile
  yes | mix elixir_ls.release -o rel
  ln -s $(pwd)/rel "$HOME/elixir-ls"
popd


