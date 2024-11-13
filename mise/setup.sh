#!/usr/bin/env bash

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

for CONFIG_FILE in config.toml; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${HOME}/.${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done

# install all asdf language plugins
echo "installing mise language plugins"

# install configured versions
echo "installing languages"
cd $HOME
mise install
cd -
