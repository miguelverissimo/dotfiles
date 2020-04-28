#!/usr/bin/env bash

set -e
CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

echo "clone prezto"
# git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

ROOT_FILES="zshrc"

for CONFIG_FILE in $ROOT_FILES; do
  if [ -e ${HOME}/.${CONFIG_FILE} ]; then
    echo "Backing current ${HOME}/.${CONFIG_FILE} to ${HOME}/.${CONFIG_FILE}.prev"
    mv ${HOME}/.${CONFIG_FILE}{,.prev}
  fi

  echo "creating ${HOME}/.${CONFIG_FILE} symlinked to ${CONFIGS_DIR}/${CONFIG_FILE}"
  ln -s ${CONFIGS_DIR}/${CONFIG_FILE} ${HOME}/.${CONFIG_FILE}
done

echo "Now run all the symlinking for the supported software"
# TODO: for every directory, run the config.sh
