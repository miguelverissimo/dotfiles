#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

ROOT_FILES="zshrc \
            zlogin \
            zlogout \
            zprofile \
            zshenv"

for CONFIG_FILE in $ROOT_FILES; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${HOME}/.${CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done
