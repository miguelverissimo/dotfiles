#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

# Run the dependencies install script first
./_dependencies/setup.sh

ROOT_FILES="zshrc"

for CONFIG_FILE in $ROOT_FILES; do
  ORIGIN="${CONFIG_FILE}"
  DEST="${HOME}/.${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done

echo "Now run all the symlinking for the supported software"
CONFIGURATION_DIRS="alacritty \
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
