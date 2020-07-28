#!/usr/bin/env bash

set -e

source ./_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

ROOT_FILES="zpreztorc"

for CONFIG_FILE in $ROOT_FILES; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${HOME}/.${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done

# install custom prompts
for CONFIG_FILE in custom-prompts/*; do
  ORIGIN="${CONFIGS_DIR}/custom-prompts/${CONFIG_FILE}"
  DEST="${ZDOTDIR:-$HOME}/.zprezto/modules/prompts/${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done
