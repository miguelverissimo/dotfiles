#!/usr/bin/env zsh

emulate -LR bash
set -e

source ./_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

# Run the dependencies install script first
./_dependencies/setup.sh

# Link zsh and prezto dotfiles
DOTFILES_DIRS="zsh \
               prezto"

for DOTFILE in ${DOTFILES_DIRS}; do
  cd ${DOTFILE}
  echo "### Configuring ${DOTFILE} ###"
  ./setup.sh
  echo "### Finished configuring ${DOTFILE} ###"
  cd ..
done

source $HOME/.zshrc

# All configuration
echo "Running all the symlinking for the supported software"
CONFIGURATION_DIRS="asdf \
                    ctags \
                    desktop_files \
                    elixir \
                    git \
                    javascript \
                    lazygit \
                    nvim-user-configs \
                    psqlrc \
                    ruby \
                    tmux \
                    utils \
                    vim \
                    wezterm"

for CONFIGURATION in ${CONFIGURATION_DIRS}; do
  cd ${CONFIGURATION}
  echo "### Configuring ${CONFIGURATION} ###"
  ./setup.sh
  echo "### Finished configuring ${CONFIGURATION} ###"
  cd ..
done
