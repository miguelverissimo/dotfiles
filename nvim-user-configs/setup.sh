#!/usr/bin/env bash

set -e

source ../_setup_scripts/backup_and_symlink

CONFIGS_DIR=$(cd "$(dirname "$0")"; pwd)

for CONFIG_FILE in tool-versions asdfrc; do
  ORIGIN="${CONFIGS_DIR}/${CONFIG_FILE}"
  DEST="${HOME}/.config/nvim/user/{CONFIG_FILE}"

  backup_and_symlink ${ORIGIN} ${DEST}
done
