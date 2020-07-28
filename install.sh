#!/usr/bin/env bash

set -e

source ./_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

# Run the dependencies install script first
./_dependencies/setup.sh

# Link zsh and prezto dotfiles
DOTFILES_DIRS="zsh \
               zprezto"

for CONFIGURATION in ${CONFIGURATION_DIRS}; do
  pushd ${CONFIGURATION}
  echo "### Configuring ${CONFIGURATION} ###"
  ./setup.sh
  echo "### Finished configuring ${CONFIGURATION} ###"
  popd
done

source $HOME/.zshrc

# All configuration
echo "Running all the symlinking for the supported software"
CONFIGURATION_DIRS="alacritty \
                    asdf \
                    ctags \
                    elixir \
                    git \
                    javascript \
                    nvim-user-configs \
                    ruby \
                    tmux \
                    utils \
                    vim"

for CONFIGURATION in ${CONFIGURATION_DIRS}; do
  pushd ${CONFIGURATION}
  echo "### Configuring ${CONFIGURATION} ###"
  ./setup.sh
  echo "### Finished configuring ${CONFIGURATION} ###"
  popd
done
