#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)
GIT_TEMPLATE_DIR="${CONFIGS_DIR}/git_template"

git config --global init.templatedir $GIT_TEMPLATE_DIR

echo "Ensure there's a .gitmessage file..."
touch ${HOME}/.gitmessage

for CONFIG_FILE in gitconfig gitignore; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${HOME}/.${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done
